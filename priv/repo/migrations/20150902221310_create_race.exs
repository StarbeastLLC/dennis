defmodule Dennis.Repo.Migrations.CreateRace do
  use Ecto.Migration

  def change do
    create table(:races) do
      add :name, :string
      add :date, :datetime

      timestamps
    end

  end
end
