defmodule Dennis.Repo.Migrations.AddUserAndCauseToChallenge do
  use Ecto.Migration

  def change do
  	alter table(:challenges) do
  		add :user_id, references(:users)
  		add :cause_id, references(:causes)
  	end
  end
end
