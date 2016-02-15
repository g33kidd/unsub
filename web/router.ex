defmodule Unsub.Router do
  use Unsub.Web, :router

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

  scope "/", Unsub do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", Unsub do
    pipe_through :browser

    get "/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  scope "/api", Unsub do
    pipe_through :api
  end
end
