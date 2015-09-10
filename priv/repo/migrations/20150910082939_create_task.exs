defmodule JiraDashboard.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :weight, :integer
      add :position, :integer

      timestamps
    end
  end
end
