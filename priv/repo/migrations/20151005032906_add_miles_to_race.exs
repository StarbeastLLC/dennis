defmodule Dennis.Repo.Migrations.AddMilesToRace do
  use Ecto.Migration

  def change do
  	alter table(:races) do
  		add :miles, :integer
  	end
  end
end
