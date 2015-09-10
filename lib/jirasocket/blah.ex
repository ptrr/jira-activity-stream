# FIXME RENAME EVERYTHING

defmodule Jirasocket.Blah do
  def start_link do
# initialize access to the jira module
    oauth = 
    [ site: "https://youngcapital.atlassian.net",
      private_key_file: "rsa-key.pem",
      consumer_key: "jira-dashboard-oath-1",

      access_token: 'FILLME AFTER DOING AUTH',
      access_token_secret: 'FILLME AFTER DOING AUTH'
    ]
    :ok = ExJira.Config.set(oauth)
    hash = HashDict.new
    hash = Dict.put(hash, "STARTED_FROM", "blah")

        IO.inspect "OMG ? "

    Agent.start_link(fn -> 
                       IO.inspect "OMG NO IT DOESN'T WORK"
                       hash
                     end, name: __MODULE__)
  end
  def add_word(word) do
# add the jira item code + the timestamp as a string once a given item has been seen with the given date
    Agent.update(__MODULE__,
      fn dict ->
        Dict.update(dict, word, 1, &(&1+1))
      end)
  end
  def count_for(word) do
# returns the count of seens for a given item code and timestamp, as such if this is > 0 then it's a duplicate
    Agent.get(__MODULE__, fn dict -> Dict.get(dict, word) end)
  end
  def words do
    Agent.get(__MODULE__, fn dict -> Dict.keys(dict) end)
  end
 def jira_thingy do
   IO.inspect Agent.get(__MODULE__, fn dict -> Dict.get(dict, "JIRA_ACCESS_BLAH") end)
   5
 end
end
