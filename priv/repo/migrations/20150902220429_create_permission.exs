defmodule Dennis.Repo.Migrations.CreatePermission do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :name, :string
      add :resource_id, :integer
      add :resource_type, :string

      timestamps
    end

  end
end
