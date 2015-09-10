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
    broadcast! socket, "test:message", payload
    {:noreply, socket}
  end

  def handle_out("test:message", payload, socket) do
    push socket, "test:message", payload
    {:noreply, socket}
  end

  def activity_message(%{type: "update", content: _}) do
    %{ type: 'update', content: "Updated message" }
  end

  def activity_message(%{type: _, content: _}) do
    %{ type: 'unknown', content: "Unknown Message" }
  end
end
