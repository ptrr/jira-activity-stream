defmodule JiraDashboard.TaskQuery do
  import Ecto.Query

  def grouped do
    [
      JiraDashboard.TaskQuery.active,
      JiraDashboard.TaskQuery.in_progress,
      JiraDashboard.TaskQuery.done
    ]
  end

  def active do
    query = from tasks in JiraDashboard.Task,
            where: tasks.status == "Active",
            select: tasks
    JiraDashboard.Repo.all query
  end

  def in_progress do
    query = from tasks in JiraDashboard.Task,
            where: tasks.status == "In Progress",
            select: tasks
    JiraDashboard.Repo.all query
  end

  def done do
    query = from tasks in JiraDashboard.Task,
            where: tasks.status == "Done",
            select: tasks
    JiraDashboard.Repo.all query
  end
end
