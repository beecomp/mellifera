defmodule Mellifera.Repo do
  use Ecto.Repo,
    otp_app: :mellifera,
    adapter: Ecto.Adapters.Postgres
end
