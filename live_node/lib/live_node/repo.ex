defmodule LiveNode.Repo do
  use Ecto.Repo,
    otp_app: :live_node,
    adapter: Ecto.Adapters.Postgres
end
