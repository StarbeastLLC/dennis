defmodule Dennis.Repo.Migrations.AddChallengeToRace do
  use Ecto.Migration

  def change do
  	alter table(:races) do
  		add :challenge_id, references(:challenges)
  	end
  end
end
