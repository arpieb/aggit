defmodule Aggit.FeedEntryTest do
  use Aggit.ModelCase

  alias Aggit.FeedEntry

  @valid_attrs %{author: "some content", duration: "some content", enclosure: %{}, entry_id: "some content", image: "some content", link: "some content", subtitle: "some content", summary: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FeedEntry.changeset(%FeedEntry{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FeedEntry.changeset(%FeedEntry{}, @invalid_attrs)
    refute changeset.valid?
  end
end
