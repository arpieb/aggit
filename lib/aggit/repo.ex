defmodule Aggit.Repo do
  use Ecto.Repo, otp_app: :aggit
  use Scrivener, page_size: 20, max_page_size: 100
end
