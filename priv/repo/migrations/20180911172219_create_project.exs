defmodule Jamjaman.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:project) do
      add :title, :string
      add :description, :text
      add :status, :string
      add :is_ofr, :boolean, default: false, null: false
      add :is_approved, :boolean, default: false, null: false
      add :approval_time, :naive_datetime
      add :worker_id, references(:user, on_delete: :nothing)
      add :user_id, references(:user, on_delete: :nothing)
      add :category_id, references(:category, on_delete: :nothing)

      timestamps()
    end

    create index(:project, [:worker_id])
    create index(:project, [:user_id])
    create index(:project, [:category_id])
  end
end
