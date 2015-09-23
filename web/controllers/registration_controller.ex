defmodule Dennis.RegistrationController do
  use Dennis.Web, :controller
  alias Dennis.User

  plug :scrub_params, "user" when action in [:create, :update]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.register_changeset(%User{}, user_params)

    if changeset.valid? do
      # save new user and sign them in
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
end
