defmodule Dennis.Registration do
  import Ecto.Changeset, only: [put_change: 3]

  def create(changeset) do
    changeset
    |> put_change(:hashed_pswd, hashed_password(changeset.params["password"]))
    |> Dennis.Repo.insert()
  end

  def create_org(changeset) do
    changeset
    |> put_change(:hashed_pswd, hashed_password(changeset.params["password"]))
    |> Dennis.Repo.update
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
