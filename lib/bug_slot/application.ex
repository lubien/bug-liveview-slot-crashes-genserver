defmodule BugSlot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BugSlotWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BugSlot.PubSub},
      # Start Finch
      {Finch, name: BugSlot.Finch},
      # Start the Endpoint (http/https)
      BugSlotWeb.Endpoint
      # Start a worker by calling: BugSlot.Worker.start_link(arg)
      # {BugSlot.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BugSlot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BugSlotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
