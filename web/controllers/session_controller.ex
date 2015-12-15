defmodule Dennis.SessionController do
  use Dennis.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case Dennis.Session.login(session_params["email"], session_params["password"]) do
      {:ok, user = %{user_type: "org", stripe_id: nil}} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Welcome back! Please connect a Stripe account so you can be part of a challenge and start receiving donations.")
        |> redirect(to: "/profile")

      {:ok, user = %{user_type: "org"}} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Welcome!")
        |> redirect(to: "/dashboard")

      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Welcome, #{user.first_name}! Please start your challenge.")
        |> redirect(to: "/dashboard/challenge")

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
