defmodule ReactChatroom.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ReactChatroom.Repo,
      # Start the Telemetry supervisor
      ReactChatroomWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ReactChatroom.PubSub},
      # Start the Endpoint (http/https)
      ReactChatroomWeb.Endpoint
      # Start a worker by calling: ReactChatroom.Worker.start_link(arg)
      # {ReactChatroom.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReactChatroom.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ReactChatroomWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
