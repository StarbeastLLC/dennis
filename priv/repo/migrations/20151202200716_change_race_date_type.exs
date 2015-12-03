defmodule Dennis.Repo.Migrations.ChangeRaceDateType do
  use Ecto.Migration

  def change do
  	alter table(:races) do
  		remove :date 

  		add :date, :date
  	end
  end
end
