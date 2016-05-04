defmodule Aggit.Repo.Migrations.CreateFeedSource do
  use Ecto.Migration

  def change do
    create table(:feed_sources) do
      add :feed_url, :string
      add :feed_name, :string
      add :author, :string
      add :image, :string
      add :link, :string
      add :language, :string
      add :subtitle, :string
      add :summary, :string
      add :title, :string
      add :last_retrieved, :datetime
      add :schedule, :string

      timestamps
    end
    create unique_index(:feed_sources, [:feed_url])

  end
end
