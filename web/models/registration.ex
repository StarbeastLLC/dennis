defmodule Dennis.Registration do
  import Ecto.Changeset, only: [put_change: 3]

  alias Dennis.Cause

  def create(changeset) do
    changeset
    |> put_change(:hashed_pswd, hashed_password(changeset.params["password"]))
    |> Dennis.Repo.insert()
  end

  def create_org(changeset, cause_photos) do
    changeset
    |> put_change(:hashed_pswd, hashed_password(changeset.params["password"]))
    |> Dennis.Repo.update
    |> create_org_as_cause(cause_photos)
  end

  defp create_org_as_cause({:error, invalid_user_changeset} = error, _) do
     error
  end

  defp create_org_as_cause({:ok, user}, cause_photos) do
    cause_params = %{
      name: user.org_name,
      country: user.country,
      state: user.state,
      description: user.description,
      more_info: user.website,
      user_id: user.id
    }

    # we use this changeset just to
    # validate if user has provided all data
    cause_changeset = 
        Cause.changeset(%Cause{}, cause_params)
        |> Cause.changeset_photos(cause_photos)

    if cause_changeset.valid? do
      Cause.changeset(%Cause{}, cause_params)
      |> Dennis.Repo.insert!
      # save photos once we have a cause.id
      |> Cause.changeset_photos(cause_photos)
      |> Dennis.Repo.update
      {:ok, user}
    else
      error_changeset = Dennis.User.changeset(user)
      error_changeset = %{error_changeset | errors: cause_changeset.errors}
      {:error, error_changeset}
    end
  end

  def hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
