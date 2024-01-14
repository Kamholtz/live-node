defmodule LiveNode.VideoDownload.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :duration_msecs, :integer
    field :status, Ecto.Enum, values: [:in_progress, :success, :error]
    field :title, :string
    field :url, :string
    field :content_type, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :url, :duration_msecs, :status])
    |> validate_required([:title, :url, :duration_msecs, :status])
  end
end
