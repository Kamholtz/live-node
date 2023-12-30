defmodule LiveNode.Notetaking.Template do
  use Ecto.Schema
  import Ecto.Changeset

  schema "templates" do
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(template, attrs) do
    template
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
