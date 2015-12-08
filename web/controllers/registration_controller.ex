defmodule Dennis.RegistrationController do
  use Dennis.Web, :controller

  import Ecto.Changeset, only: [put_change: 3]

  alias Dennis.User
  alias Dennis.Session
  alias Dennis.Registration

  plug :scrub_params, "user" when action in [:create, :update]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def new_org(conn, %{"token" => token}) do
    user = User.validate_token(token)

    cond do
      user == nil ->
        conn
        |> put_flash(:error, "It appears your invitation token has expired, please request a new one.")
        |> redirect(to: "/request-invite")
      user ->
        changeset = User.changeset(user)
        render conn, "new.html", changeset: changeset, user: user
    end    
  end
  

  def create(conn, %{"user" => user_params}) do
    changeset = User.register_changeset(%User{}, user_params)

    if changeset.valid? do
      {:ok, user} = Dennis.Registration.create(changeset)
      conn
      |> put_session(:current_user, user.id)
      |> put_flash(:info, "Welcome, #{Map.get(user_params, "first_name")}! Please start your challenge.")
      |> redirect(to: "/dashboard/challenge")
    else
      conn
      |> put_flash(:info, "Oops! Something went wrong, please try again.")
      |> render("new.html", changeset: changeset)
    end
  end

  def create_org(conn, %{"user" => user_params} = params) do 
    cause_photos = Map.get(params, "cause_photos", [])
    user = Repo.get! User, user_params["id"]
    changeset = User.register_org_changeset(user, user_params)
    case Dennis.Registration.create_org(changeset, cause_photos) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Amazing, #{Map.get(user_params, "first_name")}! You can now be part of a challenge and start receiving donations.")
        |> redirect(to: "/dashboard")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops! Something went wrong, please try again.")
        |> render("new.html", changeset: changeset, user: user)
    end
  end

  defp fb_login_or_create(user_params) do
    user = User.get_by_email(user_params["email"])
    cond do
      user && user.fb_id == user_params["fb_id"] ->
        {:ok, user}
      user ->
        {:cant_fb_login}
      :else ->
        Repo.insert User.fb_auth_changeset(%User{}, user_params)
    end
  end

  def fb_auth(conn, %{"user" => user_params}) do
    case fb_login_or_create(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Welcome, #{Map.get(user_params, "first_name")}!")
        |> redirect(to: "/dashboard")
      {:cant_fb_login} ->
        conn
        |> put_flash(:error, "It appears your account is not linked to Facebook, please login using your email and password.")
        |> redirect(to: "/login")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops! Something went wrong, please try again.")
        |> render("new.html", changeset: changeset)
    end
  end

  def profile(conn, _params) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)
    changeset = User.profile_changeset(user)
    render(conn, "profile.html", user: user, changeset: changeset)
  end

  def change_password(conn, %{"pswd_params" => password_params}) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)

    case Session.authenticate(user, password_params["old_password"]) do
      true ->
        hashed_pswd = Registration.hashed_password(password_params["password"])
        password_params = %{"password" => password_params["password"], "hashed_pswd" => hashed_pswd} 
        changeset = User.change_password_changeset(user, password_params)
        Dennis.Repo.update(changeset)

        conn
        |> put_flash(:info, "Your new password has been set correctly.")
        |> redirect(to: "/profile")
      _    ->
        conn
        |> put_flash(:info, "Password mismatch.")
        |> redirect(to: "/profile")
    end

  end

  def update_profile(conn, %{"user" => user_params}) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)
    changeset = User.update_changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Your profile has been updated.")
        |> redirect(to: "/profile")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops! Something went wrong, please try again.")
        |> render("profile.html", user: user, changeset: changeset)
    end
  end

  def connect_stripe(conn, params) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)
    code = params["code"]

    if params["error"] == nil do
      stripe_id = get_stripe_account_id(code)

      stripe_params = %{"stripe_id" => stripe_id}
      changeset = User.stripe_changeset(user, stripe_params)
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Stripe was connected successfully.")
      |> redirect(to: "/profile")
    else
      conn
      |> put_flash(:error, "Please try again to connect Stripe.")
      |> redirect(to: "/profile")
    end
  end

  defp get_stripe_account_id(code) do
    stripe_auth_url = "https://connect.stripe.com/oauth/token"
    body = {:form, [client_secret: "sk_test_BxsY2JiapXjqgvqxFy9EvVUE", code: code, grant_type: "authorization_code"]}
    {:ok, response} = HTTPoison.post(stripe_auth_url, body)

    stripe_response = Poison.Parser.parse!(response.body)
    stripe_user_id = stripe_response["stripe_user_id"]
  end

  
end
