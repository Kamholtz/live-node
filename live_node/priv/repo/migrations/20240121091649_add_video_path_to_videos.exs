defmodule LiveNode.Repo.Migrations.AddVideoPathToVideos do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :video_path, :string
    end
  end
end
