defmodule Dennis.Repo.Migrations.CreateChallenge do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :name, :string
      add :description, :string
      add :photo, :binary
      add :shares_count, :integer
      add :miles, :integer
      add :mile_price, :integer
      add :is_active, :boolean, default: false

      timestamps
    end

  end
end
