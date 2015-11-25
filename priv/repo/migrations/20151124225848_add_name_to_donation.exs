defmodule Dennis.Repo.Migrations.AddNameToDonation do
  use Ecto.Migration

  def change do
  	alter table(:donations) do
  		add :name, :string
  		add :is_anon, :boolean, default: false
  	end
  end
end
