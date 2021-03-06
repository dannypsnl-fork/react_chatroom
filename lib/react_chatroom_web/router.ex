defmodule ReactChatroomWeb.Router do
  use ReactChatroomWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ReactChatroomWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/room/:id", PageController, :index
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug ReactChatroomWeb.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graph", Absinthe.Plug, schema: ReactChatroomWeb.Schema
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: ReactChatroomWeb.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReactChatroomWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ReactChatroomWeb.Telemetry
    end
  end
end
