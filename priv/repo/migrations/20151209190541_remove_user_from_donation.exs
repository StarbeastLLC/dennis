defmodule Dennis.Repo.Migrations.RemoveUserFromDonation do
  use Ecto.Migration

  def change do
  	alter table(:donations) do
  		remove :user_id
  	end
  end
end
