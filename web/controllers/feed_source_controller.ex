defmodule Aggit.FeedSourceController do
  use Aggit.Web, :controller

  alias Aggit.FeedSource
  alias Aggit.FetchJob

  plug :scrub_params, "feed_source" when action in [:create, :update]

  @doc """
  Display landing page for feed sources.
  """
  def index(conn, _params) do
    feed_sources = Repo.all(FeedSource)
    render(conn, "index.html", feed_sources: feed_sources)
  end

  @doc """
  Render new feed soyrce creation page.
  """
  def new(conn, _params) do
    changeset = FeedSource.changeset(%FeedSource{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Process create request for new feed source.
  """
  def create(conn, %{"feed_source" => feed_source_params}) do
    changeset = FeedSource.changeset(%FeedSource{}, feed_source_params)

    case Repo.insert(changeset) do
      {:ok, feed_source} ->
        # Register our updated fetch job.
        FetchJob.register_job(feed_source)

        # Normal response ops.
        conn
        |> put_flash(:info, "Feed source created successfully.")
        |> redirect(to: feed_source_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
  Render detail page for feed source.
  """
  def show(conn, %{"id" => id}) do
    feed_source = Repo.get!(FeedSource, id)
    render(conn, "show.html", feed_source: feed_source)
  end

  @doc """
  Render edit page for feed source.
  """
  def edit(conn, %{"id" => id}) do
    feed_source = Repo.get!(FeedSource, id)
    changeset = FeedSource.changeset(feed_source)
    render(conn, "edit.html", feed_source: feed_source, changeset: changeset)
  end

  @doc """
  Process update request for feed source.
  """
  def update(conn, %{"id" => id, "feed_source" => feed_source_params}) do
    feed_source = Repo.get!(FeedSource, id)
    changeset = FeedSource.changeset(feed_source, feed_source_params)

    case Repo.update(changeset) do
      {:ok, feed_source} ->
        # Register our updated fetch job.
        FetchJob.register_job(feed_source)

        # Normal response ops.
        conn
        |> put_flash(:info, "Feed source updated successfully.")
        |> redirect(to: feed_source_path(conn, :show, feed_source))
      {:error, changeset} ->
        render(conn, "edit.html", feed_source: feed_source, changeset: changeset)
    end
  end

  @doc """
  Process delete request for feed source.
  """
  def delete(conn, %{"id" => id}) do
    feed_source = Repo.get!(FeedSource, id)

    # Unregister our fetch job.
    FetchJob.unregister_job(feed_source)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(feed_source)

    conn
    |> put_flash(:info, "Feed source deleted successfully.")
    |> redirect(to: feed_source_path(conn, :index))
  end

end
