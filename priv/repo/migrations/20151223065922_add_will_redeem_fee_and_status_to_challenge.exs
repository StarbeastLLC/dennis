defmodule Dennis.Repo.Migrations.AddWillRedeemFeeAndStatusToChallenge do
  use Ecto.Migration

  def change do
  	alter table(:challenges) do
  		add :will_redeem_fee, :boolean
  		add :status, :string
  	end
  end
end
