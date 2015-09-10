defmodule JiraDashboard.TaskTest do
  use JiraDashboard.ModelCase

  alias JiraDashboard.Task

  @valid_attrs %{description: "some content", position: 42, title: "some content", weight: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Task.changeset(%Task{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Task.changeset(%Task{}, @invalid_attrs)
    refute changeset.valid?
  end
end
