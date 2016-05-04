defmodule Aggit.FeedSourceTest do
  use Aggit.ModelCase

  alias Aggit.FeedSource

  @valid_attrs %{author: "some content", feed_name: "some content", feed_url: "http://elixirstatus.com", image: "some content", language: "some content", link: "some content", schedule: "some content", subtitle: "some content", summary: "some content", title: "some content"}#, last_retrieved: %{day: 17, month: 4, year: 2016, hour: 0, min: 0}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FeedSource.changeset(%FeedSource{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FeedSource.changeset(%FeedSource{}, @invalid_attrs)
    refute changeset.valid?
  end
end
