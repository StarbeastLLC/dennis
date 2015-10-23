defmodule Dennis.Repo.Migrations.AddTypeToRace do
  use Ecto.Migration

  def change do
  	alter table(:races) do
  		add :type, :string
  	end
  end
end
