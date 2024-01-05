defmodule LiveNode.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :title, :string
      add :url, :string
      add :duration_msecs, :integer
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
