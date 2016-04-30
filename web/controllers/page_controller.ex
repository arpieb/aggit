defmodule Aggit.PageController do
  use Aggit.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
