defmodule Aggit.FeedSource do
  use Aggit.Web, :model

  schema "feed_sources" do
    field :feed_url, :string
    field :feed_name, :string
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

  @required_fields ~w(feed_url feed_name)
  @optional_fields ~w(author image link language subtitle summary title last_retrieved schedule)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)

    # Validations.
    |> validate_url(:feed_url)
    |> validate_feed(:feed_url)

    # Constraints.
    |> unique_constraint(:feed_url)
  end

  @doc """
  Parse URL and verify at a minimum it has a scheme and host.
  """
  def validate_url(changeset, field) do
    validate_change changeset, field, fn(field, value) ->
      parsed_url = URI.parse(value)
      case parsed_url do
        %URI{host: nil} -> [{field, "URL missing host"}]
        %URI{scheme: nil} -> [{field, "URL missing scheme"}]
        _ -> []
      end
    end
  end

  @doc """
  Verify that the URL is reachable.
  """
  def validate_feed(changeset, field) do
    validate_change changeset, field, fn(field, value) ->
      case HTTPoison.get(value) do
        {:ok, _} -> []
        _ -> [{field, "URL is not reachable"}]
      end
    end
  end
end
