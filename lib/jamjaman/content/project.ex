defmodule Jamjaman.Content.Project do
  use Ecto.Schema
  import Ecto.Changeset


  schema "project" do
    field :approval_time, :naive_datetime
    field :description, :string
    field :is_approved, :boolean, default: false
    field :is_ofr, :boolean, default: false
    field :status, :string
    field :title, :string
    field :worker_id, :id
    field :user_id, :id
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :description, :status, :is_ofr, :is_approved, :approval_time])
    |> validate_required([:title, :description, :status, :is_ofr, :is_approved, :approval_time])
  end
end
