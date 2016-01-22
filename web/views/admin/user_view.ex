defmodule Dennis.Admin.UserView do
  use Dennis.Web, :view

  alias Dennis.User
  alias Dennis.Repo

  def org_changeset(id) do
  	user = Repo.get!(User, id)
  	User.invited_org_changeset(user)
  end
end
