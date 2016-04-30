defmodule Aggit.Feed do
  use Aggit.Web, :model

  schema "feeds" do
    field :url, :string
    field :author, :string
    field :image, :string
    field :link, :string
    field :language, :string
    field :subtitle, :string
    field :summary, :string
    field :title, :string
    field :last_retrieved, Ecto.DateTime
    field :schedule, :string

    timestamps
  end

  @required_fields ~w(url author image link language subtitle summary title last_retrieved schedule)
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