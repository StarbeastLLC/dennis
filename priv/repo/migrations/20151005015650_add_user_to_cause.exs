defmodule Dennis.Repo.Migrations.AddUserToCause do
  use Ecto.Migration

  def change do
  	alter table(:causes) do
  		add :user_id, references(:users)
  	end
  end
end
