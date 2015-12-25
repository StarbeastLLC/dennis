defmodule Dennis.Repo.Migrations.AddDestinationAccountToDonation do
  use Ecto.Migration

  def change do
  	alter table(:donations) do
  		add :destination_account, :string
  	end
  end
end
