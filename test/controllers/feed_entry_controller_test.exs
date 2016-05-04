defmodule Aggit.FeedEntryControllerTest do
  use Aggit.ConnCase

  alias Aggit.FeedEntry
  @valid_attrs %{author: "some content", duration: "some content", enclosure: %{}, entry_id: "some content", image: "some content", link: "some content", subtitle: "some content", summary: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feed_entry_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing feed entries"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, feed_entry_path(conn, :new)
    assert html_response(conn, 200) =~ "New feed entry"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, feed_entry_path(conn, :create), feed_entry: @valid_attrs
    assert redirected_to(conn) == feed_entry_path(conn, :index)
    assert Repo.get_by(FeedEntry, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feed_entry_path(conn, :create), feed_entry: @invalid_attrs
    assert html_response(conn, 200) =~ "New feed entry"
  end

  test "shows chosen resource", %{conn: conn} do
    feed_entry = Repo.insert! %FeedEntry{}
    conn = get conn, feed_entry_path(conn, :show, feed_entry)
    assert html_response(conn, 200) =~ "Show feed entry"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, feed_entry_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    feed_entry = Repo.insert! %FeedEntry{}
    conn = get conn, feed_entry_path(conn, :edit, feed_entry)
    assert html_response(conn, 200) =~ "Edit feed entry"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    feed_entry = Repo.insert! %FeedEntry{}
    conn = put conn, feed_entry_path(conn, :update, feed_entry), feed_entry: @valid_attrs
    assert redirected_to(conn) == feed_entry_path(conn, :show, feed_entry)
    assert Repo.get_by(FeedEntry, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    feed_entry = Repo.insert! %FeedEntry{}
    conn = put conn, feed_entry_path(conn, :update, feed_entry), feed_entry: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit feed entry"
  end

  test "deletes chosen resource", %{conn: conn} do
    feed_entry = Repo.insert! %FeedEntry{}
    conn = delete conn, feed_entry_path(conn, :delete, feed_entry)
    assert redirected_to(conn) == feed_entry_path(conn, :index)
    refute Repo.get(FeedEntry, feed_entry.id)
  end
end
