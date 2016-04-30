defmodule Aggit.FeedEntry do
  use Aggit.Web, :model

  schema "feed_entries" do
    field :author, :string
    field :duration, :string
    field :enclosure, :map
    field :entry_id, :string
    field :image, :string
    field :link, :string
    field :subtitle, :string
    field :summary, :string
    field :title, :string

    timestamps
  end

  @required_fields ~w(author duration enclosure entry_id image link subtitle summary title)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
