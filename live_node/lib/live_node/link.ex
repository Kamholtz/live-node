defmodule LiveNode.Promo.Link do
  defstruct [:url, :text]
  @types %{url: :string, text: :string}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = user, attrs) do
    {user, @types}
    |> cast(attrs, Map.keys(@types))
  end
end


