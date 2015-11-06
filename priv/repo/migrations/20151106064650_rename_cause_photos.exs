defmodule Dennis.Repo.Migrations.RenameCausePhotos do
  use Ecto.Migration

  def change do
  	alter table(:causes) do
  		remove :photo_video

  		add :photo1, :string
  		add :photo2, :string
  		add :photo3, :string
  		add :photo4, :string
  		add :photo5, :string
  	end
  end
end
