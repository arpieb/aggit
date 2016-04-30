defmodule Aggit.Repo.Migrations.CreateFeedEntry do
  use Ecto.Migration

  def change do
    create table(:feed_entries) do
      add :author, :string
      add :duration, :string
      add :enclosure, :map
      add :entry_id, :string
      add :image, :string
      add :link, :string
      add :subtitle, :string
      add :summary, :string
      add :title, :string

      timestamps
    end

  end
end
