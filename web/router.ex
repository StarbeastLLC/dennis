defmodule Dennis.Router do
  use Dennis.Web, :router

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

  scope "/", Dennis do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/permissions", PermissionController
    resources "/challenges", ChallengeController
    resources "/causes", CauseController
    resources "/donations", DonationController
    resources "/races", RaceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dennis do
  #   pipe_through :api
  # end
end
