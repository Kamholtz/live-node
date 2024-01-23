defmodule LiveNode.VideoDownload.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :duration_msecs, :integer
    field :status, Ecto.Enum, values: [:in_progress, :success, :error]
    field :title, :string
    field :url, :string
    field :content_type, :string
    field :video_file, :any, virtual: true # used for saving it seems (?)
    field :video_path, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :url, :duration_msecs, :status, :content_type, :video_path])
    |> validate_required([:url]) # user can set a title, and have it override what's extracted
  end
end
