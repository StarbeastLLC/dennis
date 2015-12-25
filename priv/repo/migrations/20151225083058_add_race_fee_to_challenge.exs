defmodule Dennis.Repo.Migrations.AddRaceFeeToChallenge do
  use Ecto.Migration

  def change do
  	alter table(:challenges) do
  		add :race_fee, :integer
  	end
  end
end
