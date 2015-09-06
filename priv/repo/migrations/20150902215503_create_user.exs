defmodule Dennis.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email,         :string
      add :hashed_pswd,   :string
      add :reset_token,   :string
      add :is_admin,      :boolean, default: false
      add :is_active,     :boolean, default: false
      add :fb_id,         :string
      add :fb_token,      :string
      add :first_name,    :string
      add :last_name,     :string
      add :description,   :string
      add :country,       :string
      add :state,         :string
      add :address,       :string
      add :stripe_id,     :string
      add :user_type,     :string
      add :website,       :string
      add :org_name,      :string
      add :logo,          :binary
      add :photo_video,   :binary

      timestamps
    end

    create unique_index(:users, [:email])

  end
end
