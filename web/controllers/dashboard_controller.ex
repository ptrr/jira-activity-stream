defmodule JiraDashboard.DashboardController do
  use JiraDashboard.Web, :controller

  alias JiraDashboard.Dashboard
  alias JiraDashboard.TaskQuery

  def index(conn, _params) do
    grouped_tasks = JiraDashboard.TaskQuery.grouped
    render(conn, "index.html", grouped_tasks: grouped_tasks)
  end
end
