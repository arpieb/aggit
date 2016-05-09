defmodule Aggit.FeedSourceControllerTest do
  use Aggit.ConnCase

  alias Aggit.FeedSource
  @valid_attrs %{author: "some content", feed_name: "some content", feed_url: "http://elixirstatus.com/rss", image: "some content", language: "some content", last_retrieved: %{day: 17, month: 4, year: 2016, hour: 0, min: 0}, link: "some content", schedule: "some content", subtitle: "some content", summary: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feed_source_path(conn, :index)
    assert html_response(conn, 200) =~ "Feed Sources"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, feed_source_path(conn, :new)
    assert html_response(conn, 200) =~ "New feed source"
  end

#  test "creates resource and redirects when data is valid", %{conn: conn} do
#    conn = post conn, feed_source_path(conn, :create), feed_source: @valid_attrs
#    assert redirected_to(conn) == feed_source_path(conn, :index)
#    assert Repo.get_by(FeedSource, @valid_attrs)
#  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feed_source_path(conn, :create), feed_source: @invalid_attrs
    assert html_response(conn, 200) =~ "New feed source"
  end

  test "shows chosen resource", %{conn: conn} do
    feed_source = Repo.insert! %FeedSource{feed_name: "some content", feed_url: "foo", link: "bar"}
    conn = get conn, feed_source_path(conn, :show, feed_source)
    assert html_response(conn, 200) =~ "some content"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, feed_source_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    feed_source = Repo.insert! %FeedSource{}
    conn = get conn, feed_source_path(conn, :edit, feed_source)
    assert html_response(conn, 200) =~ "Edit feed source"
  end

#  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
#    feed_source = Repo.insert! %FeedSource{}
#    conn = put conn, feed_source_path(conn, :update, feed_source), feed_source: @valid_attrs
#    assert redirected_to(conn) == feed_source_path(conn, :show, feed_source)
#    assert Repo.get_by(FeedSource, @valid_attrs)
#  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    feed_source = Repo.insert! %FeedSource{}
    conn = put conn, feed_source_path(conn, :update, feed_source), feed_source: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit feed source"
  end

  test "deletes chosen resource", %{conn: conn} do
    feed_source = Repo.insert! %FeedSource{}
    conn = delete conn, feed_source_path(conn, :delete, feed_source)
    assert redirected_to(conn) == feed_source_path(conn, :index)
    refute Repo.get(FeedSource, feed_source.id)
  end
end
