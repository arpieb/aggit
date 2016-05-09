defmodule Aggit.FeedEntryController do
  use Aggit.Web, :controller

  alias Aggit.FeedEntry

  plug :scrub_params, "feed_entry" when action in [:create, :update]

  def index(conn, params) do
    page = Repo.paginate(FeedEntry, params)
    render(conn, "index.html", page: page)
  end

  def new(conn, _params) do
    changeset = FeedEntry.changeset(%FeedEntry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed_entry" => feed_entry_params}) do
    changeset = FeedEntry.changeset(%FeedEntry{}, feed_entry_params)

    case Repo.insert(changeset) do
      {:ok, _feed_entry} ->
        conn
        |> put_flash(:info, "Feed entry created successfully.")
        |> redirect(to: feed_entry_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed_entry = Repo.get!(FeedEntry, id)
    render(conn, "show.html", feed_entry: feed_entry)
  end

  def edit(conn, %{"id" => id}) do
    feed_entry = Repo.get!(FeedEntry, id)
    changeset = FeedEntry.changeset(feed_entry)
    render(conn, "edit.html", feed_entry: feed_entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed_entry" => feed_entry_params}) do
    feed_entry = Repo.get!(FeedEntry, id)
    changeset = FeedEntry.changeset(feed_entry, feed_entry_params)

    case Repo.update(changeset) do
      {:ok, feed_entry} ->
        conn
        |> put_flash(:info, "Feed entry updated successfully.")
        |> redirect(to: feed_entry_path(conn, :show, feed_entry))
      {:error, changeset} ->
        render(conn, "edit.html", feed_entry: feed_entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed_entry = Repo.get!(FeedEntry, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(feed_entry)

    conn
    |> put_flash(:info, "Feed entry deleted successfully.")
    |> redirect(to: feed_entry_path(conn, :index))
  end
end
