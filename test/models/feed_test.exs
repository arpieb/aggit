defmodule Aggit.FeedTest do
  use Aggit.ModelCase

  alias Aggit.Feed

  @valid_attrs %{author: "some content", image: "some content", language: "some content", last_retrieved: "2010-04-17 14:00:00", link: "some content", schedule: "some content", subtitle: "some content", summary: "some content", title: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Feed.changeset(%Feed{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Feed.changeset(%Feed{}, @invalid_attrs)
    refute changeset.valid?
  end
end
