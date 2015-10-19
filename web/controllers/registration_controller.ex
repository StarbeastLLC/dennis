defmodule Dennis.RegistrationController do
  use Dennis.Web, :controller
  alias Dennis.User

  plug :scrub_params, "user" when action in [:create, :update]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def new_org(conn, %{"token" => token}) do
    # TODO Check if token exists on DB, if not ERROR
    changeset = User.changeset(%User{:user_type => "org"})
    render conn, "new.html", changeset: changeset
  end
  

  def create(conn, %{"user" => user_params}) do
    changeset = User.register_changeset(%User{}, user_params)

    if changeset.valid? do
      # save new user and sign them in
      # TO-DO: add {:error, user} case
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

  def fb_auth(conn, %{"user" => user_params}) do
    changeset = User.register_changeset(%User{}, user_params)

    if changeset.valid? do
      # save new user and sign them in
      # TO-DO: add {:error, user} case
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

  def profile(conn, _params) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "profile.html", user: user, changeset: changeset)
  end

  def update_profile(conn, %{"user" => user_params}) do
    id = get_session(conn, :current_user)
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        #|> redirect(to: admin_user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "profile.html", user: user, changeset: changeset)
    end
  end
end
