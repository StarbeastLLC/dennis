defmodule Dennis.Admin.UserController do
  use Dennis.Web, :controller

  alias Dennis.User
  alias Dennis.Mailer

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def index_orgs(conn, _params) do
    enqueued_orgs = User.get_enqueued_orgs
    render(conn, "index-orgs.html", charities: enqueued_orgs)
  end

  def invite_org(conn, user_params) do
    user_params = user_params["invite"]
    token = Ecto.UUID.generate
    user_params = Map.put(user_params, "reset_token", token)
    user_data = Repo.get(User, user_params["id"])
    
    changeset = User.admin_invited_org_changeset(user_data, user_params)
    case Repo.update(changeset) do
      {:ok, user} ->
        Mailer.send_admin_invitation(user_params["email"], user_params["org_name"], token)
        conn
        |> put_flash(:info, "The charity was successfully invited!")
        |> redirect(to: "/admin/charities")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops! Something went wrong, please try again.")
        |> redirect(to: "/admin/charities")
    end
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: admin_user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: admin_user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_user_path(conn, :index))
  end
end
