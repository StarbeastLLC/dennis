defmodule Dennis.Registration do
  import Ecto.Changeset, only: [put_change: 3]

  alias Dennis.Cause

  def create(changeset) do
    changeset
    |> put_change(:hashed_pswd, hashed_password(changeset.params["password"]))
    |> Dennis.Repo.insert()
  end

  def create_org(changeset) do
    changeset
    |> put_change(:hashed_pswd, hashed_password(changeset.params["password"]))
    |> Dennis.Repo.update
    |> create_org_as_cause
  end

  defp create_org_as_cause({:error, invalid_user_changeset} = error) do
     error
  end

  defp create_org_as_cause({:ok, user}) do
    changeset = Cause.changeset %Cause{}, %{
      name: user.org_name,
      country: user.country,
      state: user.state,
      description: user.description,
      more_info: user.website,
      user_id: user.id
    }
    Dennis.Repo.insert!(changeset)
    {:ok, user}
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
