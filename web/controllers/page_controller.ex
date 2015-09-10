defmodule Jirasocket.PageController do
  use Jirasocket.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
