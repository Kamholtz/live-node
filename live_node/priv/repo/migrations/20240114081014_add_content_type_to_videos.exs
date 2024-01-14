defmodule LiveNode.Repo.Migrations.AddContentTypeToVideos do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :content_type, :string
    end
  end
end
