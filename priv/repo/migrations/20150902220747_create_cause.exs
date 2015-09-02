defmodule Dennis.Repo.Migrations.CreateCause do
  use Ecto.Migration

  def change do
    create table(:causes) do
      add :name, :string
      add :country, :string
      add :state, :string
      add :description, :string
      add :more_info, :string
      add :photo_video, :binary

      timestamps
    end

  end
end
