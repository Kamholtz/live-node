defmodule LiveNode.Notetaking.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :content, :string
    field :title, :string
    field :template_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
