defmodule Dennis.Repo.Migrations.RenameUserLogoAndPhoto do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		remove :logo
  		remove :photo_video
  		add :avatar, :string
  	end
  end
  
end
