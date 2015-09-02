defmodule Dennis.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :description, :string
      add :email, :string
      add :photo_video, :binary
      add :country, :string
      add :state, :string
      add :address, :string
      add :password, :string
      add :hash, :string
      add :recovery_hash, :string
      add :fb_id, :string
      add :fb_token, :string
      add :stripe_id, :string
      add :user_type, :string
      add :organization_name, :string
      add :website, :string
      add :logo, :binary
      add :is_admin, :boolean, default: false

      timestamps
    end

  end
end
