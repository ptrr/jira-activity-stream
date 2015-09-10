defmodule Jirasocket.ActivityChannel do
  use Phoenix.Channel
  
  def join("activity:test", auth_msg, socket) do
    {:ok, socket}
  end

  def event(socket, "test:message", message) do
    broadcast! socket, "test_message", %{type: 'test', content: message["content"]}
    socket
  end

  intercept ["activity:update"]
  def handle_in("activity:update", payload, socket) do
    message = activity_message(payload)
    broadcast! socket, "test:message", message
    {:noreply, socket}
  end

  intercept ["test:message"]
  def handle_in("test:message", payload, socket) do
    IO.puts "ignoring an incoming test:message"
    broadcast! socket, "test:message", payload
    {:noreply, socket}
  end

  def handle_out("test:message", payload, socket) do
    IO.puts "sending 2 new shits"
    IO.inspect Jirasocket.Blah.start_link
    IO.inspect Jirasocket.Blah.jira_thingy

#   id = 22817
#   fields = ExJira.API.Issues.find(id).fields
#   status = fields.status.name
#   description = fields.description
#   IO.puts "Item #{id} (#{status}) : description: #{description}"

    since_start_of_day = ExJira.API.Search.using_jql("sprint = \"Frontend (20 aug t/m 2 sep)\" AND updatedDate < \"2015/09/11 00:00\" AND updatedDate >= \"2015/09/10 00:00\"").issues
    IO.inspect Enum.map(since_start_of_day, fn (issue) ->
      uniq_key = "#{issue.key}#{issue.fields.updated}"
      if Jirasocket.Blah.count_for(uniq_key) == nil do
        new_payload = %{content: "#{issue.key} was modified!", type: 'start'}
        IO.inspect new_payload
        push socket, "test:message", new_payload
      end
      Jirasocket.Blah.add_word uniq_key
    end)

    {:noreply, socket}
  end

  def activity_message(message = %{"content" => _, "type" => "start", "name" => _, "item" => _}) do
    %{ type: 'start', content: "#{message["name"]} is working on #{message["item"]} now!" }
  end

  def activity_message(message = %{"content" => _, "type" => "update", "name" => _, "item" => _}) do
    %{ type: 'update', content: "#{message["name"]} changed #{message["item"]}" }
  end

  def activity_message(message = %{"content" => _, "type" => "complete", "name" => _, "item" => _}) do
    %{ type: 'update', content: "#{message["name"]} is done with #{message["item"]}" }
  end

  def activity_message(message = %{"content" => _, "type" => "new", "name" => _, "item" => _}) do
    %{ type: 'update', content: "#{message["name"]} added #{message["item"]}" }
  end

  # def activity_message(%{type: _, content: _}) do
  #   %{ type: 'unknown', content: "Unknown Message" }
  # end
end
