defmodule Aggit.Repo.Migrations.CreateFeed do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :url, :string
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

  end
end
