defmodule Dennis.Repo.Migrations.AddVideoToChallenge do
  use Ecto.Migration

  def change do
  	alter table(:challenges) do
  		add :video, :string
  	end
  end
end
