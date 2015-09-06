defmodule Dennis.Session do
  alias Dennis.User

  def login(email, password) do
    user = Dennis.Repo.get_by(User, email: String.downcase(email))
    case authenticate(user, password) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Dennis.Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.hashed_pswd)
    end
  end

end
