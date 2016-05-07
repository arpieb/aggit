defmodule Aggit.FetchJob do
  @moduledoc """
  Provides feed fetch job control.
  """

  require Logger

  alias Aggit.Repo
  alias Aggit.FeedSource
  alias Aggit.FeedEntry

  @doc """
  Executes the scheduled fetch task; see register_job/1.
  """
  def fetch_feed(feed_source) do
    case HTTPoison.get(feed_source.feed_url) do
      {:ok, %HTTPoison.Response{body: body}} -> process_feed(feed_source, body)
      _ -> Logger.error("Unable to retrieve feed from #{feed_source.feed_url}")
    end
  end

  @doc """
  Process feed and create new entries, see fetch_feed/1.
  """
  defp process_feed(feed_source, body) do
    case FeederEx.parse(body) do
      {:ok, feed, _} ->
        # Update feed source record.
        feed = Map.put(feed, :last_retrieved, Ecto.DateTime.utc())
        feed_source_changeset = FeedSource.changeset(feed_source, feed)
        case Repo.update(feed_source_changeset) do
          {:ok, _feed_source} ->
            # Insert any new feed entry records.
            Enum.map(feed.entries, fn(entry) ->
              feed_entry_changeset = FeedEntry.changeset(%FeedEntry{}, entry)
              Repo.insert(feed_entry_changeset)
              end
            )
          _ -> Logger.error("Unable to update FeedSource with id #{Integer.to_string(feed_source.id)}")
        end
      _ -> Logger.error("Unable to parse feed data from #{feed_source.feed_url} [#{Integer.to_string(feed_source.id)}]")
    end
  end

  @doc """
  Registers/updates the feed fetch job in Quantum.
  """
  def register_job(feed_source) do
    # Remove old job (if any) with same name.
    unregister_job(feed_source)

    # Check for schedule string.
    if (feed_source.schedule != nil) do
      # Add new task with name.
      name = get_job_name(feed_source)
      task = %Quantum.Job{
        schedule: feed_source.schedule,
        args: [feed_source],
        task: {Aggit.FetchJob, :fetch_feed}
      }
      Quantum.add_job(name, {feed_source.schedule, task})
    end
  end

  @doc """
  Register all feed jobs at once; used primarily at process init.
  """
  def register_all_jobs() do
    FeedSource
    |> Repo.all()
    |> IO.inspect
    |> Enum.map(&register_job/1)
  end

  @doc """
  Remove any existing job for this feed source.
  """
  def unregister_job(feed_source) do
    # Construct job name.
    name = get_job_name(feed_source)

    # Remove old job with same name.
    Quantum.delete_job(name)
  end

  @doc """
  Util method to consistently generate feed source job names.
  """
  def get_job_name(feed_source) do
    "aggit-feed-source-" <> Integer.to_string(feed_source.id)
  end
end
