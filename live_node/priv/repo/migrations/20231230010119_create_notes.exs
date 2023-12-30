defmodule LiveNode.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :content, :text
      add :template_id, references(:templates, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:notes, [:template_id])
  end
end
