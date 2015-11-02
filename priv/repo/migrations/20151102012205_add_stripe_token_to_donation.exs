defmodule Dennis.Repo.Migrations.AddStripeTokenToDonation do
  use Ecto.Migration

  def change do
  	alter table(:donations) do
  		add :user_id, references(:users)
  		add :challenge_id, references(:challenges)
  		add :transaction_token, :string, null: false
  		add :authorization_token, :string
  	end
  end
end
