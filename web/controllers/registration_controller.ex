defmodule Dennis.RegistrationController do
  use Dennis.Web, :controller
  alias Dennis.User

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
        |> put_flash(:error, "Your invitation token is invalid, please ask for a new one.")
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
      |> put_flash(:info, "Your account was created")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:info, "Unable to create account")
      |> render("new.html", changeset: changeset)
    end
  end

  def create_org(conn, %{"user" => user_params}) do 
    user = Repo.get! User, user_params["id"]
    changeset = User.register_org_changeset(user, user_params)
    case Dennis.Registration.create_org(changeset) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Welcome to MyMiles.")
        |> redirect(to: "/dashboard")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Please check your inputs.")
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
        |> put_flash(:info, "Welcome to MyMiles.")
        |> redirect(to: "/dashboard")
      {:cant_fb_login} ->
        conn
        |> put_flash(:error, "Please login using your password.")
        |> redirect(to: "/login")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Unable to create account")
        |> render("new.html", changeset: changeset)
    end
  end

  def profile(conn, _params) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)
    changeset = User.update_changeset(user)
    render(conn, "profile.html", user: user, changeset: changeset)
  end

  def update_profile(conn, %{"user" => user_params}) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)
    changeset = User.update_changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: "/profile")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "The data entered is invalid.")
        |> render("profile.html", user: user, changeset: changeset)
    end
  end
end
