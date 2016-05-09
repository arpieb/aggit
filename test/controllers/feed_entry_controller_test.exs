defmodule Aggit.FeedEntryControllerTest do
  use Aggit.ConnCase

  alias Aggit.FeedEntry
  @valid_attrs %{author: "some content", duration: "some content", enclosure: %{}, entry_id: "some content", image: "some content", link: "some content", subtitle: "some content", summary: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feed_entry_path(conn, :index)
    assert html_response(conn, 200) =~ "Feed Entries"
  end

  test "shows chosen resource", %{conn: conn} do
    feed_entry = Repo.insert! %FeedEntry{title: "some content", image: "foo", link: "bar"}
    conn = get conn, feed_entry_path(conn, :show, feed_entry)
    assert html_response(conn, 200) =~ "some content"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, feed_entry_path(conn, :show, -1)
    end
  end
end
