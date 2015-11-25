defmodule Dennis.SessionController do
  use Dennis.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case Dennis.Session.login(session_params["email"], session_params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Welcome!")
        |> redirect(to: "/dashboard")
      :error ->
        conn
        |> put_flash(:info, "Oops! Your email and/or password may be invalid, please try again.")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Succesfully logged out.")
    |> redirect(to: "/")
  end
end
