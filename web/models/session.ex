defmodule Dennis.Session do
  alias Dennis.User

  def login(email, password) do
    user = Dennis.Repo.get_by(User, email: String.downcase(email))
    case authenticate(user, password) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.hashed_pswd)
    end
  end
end
