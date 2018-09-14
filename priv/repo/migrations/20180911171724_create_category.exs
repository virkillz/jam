defmodule Jamjaman.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:category) do
      add :title, :string
      add :description, :text
      add :logo, :string

      timestamps()
    end

  end
end
