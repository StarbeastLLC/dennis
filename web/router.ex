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

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Dennis.AdminPlug
  end

  scope "/", Dennis do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/our-story", PageController, :our_story
    get "/our-team", PageController, :our_team
    get "/privacy", PageController, :privacy
    get "/terms", PageController, :terms
    get "/how", PageController, :how

    get "/request-invite", PageController, :request_invite
    post "/request-invite", PageController, :send_invite_request

    get  "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    put "/register", RegistrationController, :create_org
    post "/register/facebook", RegistrationController, :fb_auth
    get "/register/:token", RegistrationController, :new_org

    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete

    get "/athlete", AthleteController,      :index
    get "/donor",   DonorController,        :index
    get "/org",     OrganizationController, :index

    get "/dashboard", DashboardController, :index
    get "/profile", RegistrationController, :profile
    put "/profile", RegistrationController, :update_profile
    put "/password", RegistrationController, :change_password
    get "/stripe", RegistrationController, :profile #change

    get "/dashboard/challenge", AthleteController, :new_challenge
    post "/dashboard/challenge", AthleteController, :create_challenge
    get "/dashboard/challenge/:id", AthleteController, :show_challenge

    get "/dashboard/cause", OrgController, :new_cause
    post "/dashboard/cause", OrgController, :create_cause
    get "/dashboard/cause/:id", OrgController, :show_cause

    get "/challenges/:id", ChallengeController, :show
    get "/challenges", ChallengeController, :index

    get "/causes/:id", CauseController, :show
    get "/causes", CauseController, :index
    get "/charities", CauseController, :index_orgs
    get "/charities/:id", CauseController, :show_org

    get "/invite", PageController, :invite
    post "/invite/athlete", AthleteController, :invite
    post "/invite/org", OrgController, :invite

    get "/donate/:challenge_id", DonationController, :new
    post "/donate/:challenge_id", DonationController, :create

  end

  scope "/admin", Dennis.Admin, as: :admin do
    pipe_through :admin

    resources "/users",       UserController
    resources "/permissions", PermissionController
    resources "/challenges",  ChallengeController
    resources "/causes",      CauseController
    resources "/donations",   DonationController
    resources "/races",       RaceController

    get "/emails/athlete-invite-email", EmailController, :athlete_invite_email
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dennis do
  #   pipe_through :api
  # end
end
