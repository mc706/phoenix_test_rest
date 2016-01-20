defmodule TestRest.Router do
  use TestRest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "hal+json"]
  end

  scope "/", TestRest do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", TestRest do
    pipe_through :api

    get "/users", UserController, :index_get
    post "/users", UserController, :index_post
    options "/users", UserController, :index_options
  end
end
