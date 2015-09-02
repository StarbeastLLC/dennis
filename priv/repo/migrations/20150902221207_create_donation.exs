defmodule Dennis.Repo.Migrations.CreateDonation do
  use Ecto.Migration

  def change do
    create table(:donations) do
      add :miles_bought, :integer
      add :tip, :integer
      add :total_donated, :integer
      add :is_anonymous, :boolean, default: false

      timestamps
    end

  end
end
