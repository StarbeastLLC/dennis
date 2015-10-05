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

    get  "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    post "/facebook", RegistrationController, :fb_auth

    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete

    get "/athlete", AthleteController,      :index
    get "/donor",   DonorController,        :index
    get "/org",     OrganizationController, :index

    get "/dashboard", DashboardController, :index
    get "/dashboard/challenge", AthleteController, :new_challenge
    post "/dashboard/challenge", AthleteController, :create_challenge
    get "dashboard/challenge/:id", AthleteController, :show_challenge

  end

  scope "/admin", Dennis do
    pipe_through :browser # Use the default browser stack

    resources "/users",       UserController
    resources "/permissions", PermissionController
    resources "/challenges",  ChallengeController
    resources "/causes",      CauseController
    resources "/donations",   DonationController
    resources "/races",       RaceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dennis do
  #   pipe_through :api
  # end
end
