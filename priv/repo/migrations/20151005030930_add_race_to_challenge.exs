defmodule Dennis.Repo.Migrations.AddRaceToChallenge do
  use Ecto.Migration

  def change do
  	alter table(:challenges) do
  		add :race_id, references(:races)
  	end
  end
end
