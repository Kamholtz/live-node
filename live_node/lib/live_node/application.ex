defmodule LiveNode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveNodeWeb.Telemetry,
      LiveNode.Repo,
      {DNSCluster, query: Application.get_env(:live_node, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveNode.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveNode.Finch},
      # Start a worker by calling: LiveNode.Worker.start_link(arg)
      # {LiveNode.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveNodeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveNode.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveNodeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
