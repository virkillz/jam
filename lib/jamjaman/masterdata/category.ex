defmodule Jamjaman.Masterdata.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "category" do
    field :description, :string
    field :logo, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :description, :logo])
    |> validate_required([:title, :description, :logo])
  end
end
