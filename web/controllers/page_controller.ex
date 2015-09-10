defmodule JiraDashboard.PageController do
  use JiraDashboard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
