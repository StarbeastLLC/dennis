defmodule Dennis.Repo.Migrations.AddVideoToCause do
  use Ecto.Migration

  def change do
  	alter table(:causes) do
  		add :video, :string
  	end
  end
end
