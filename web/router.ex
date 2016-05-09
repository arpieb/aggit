defmodule Aggit.Router do
  use Aggit.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Aggit do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    # Resource routes.
    resources "/feed_sources", FeedSourceController
    resources "/feed_entries", FeedEntryController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Aggit do
  #   pipe_through :api
  # end
end
