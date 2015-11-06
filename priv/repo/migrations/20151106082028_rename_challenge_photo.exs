defmodule Dennis.Repo.Migrations.RenameChallengePhoto do
  use Ecto.Migration

  def change do
  	alter table(:challenges) do
  		remove :photo

  		add :photo1, :string
  		add :photo2, :string
  		add :photo3, :string
  		add :photo4, :string
  		add :photo5, :string
  	end
  end
end
