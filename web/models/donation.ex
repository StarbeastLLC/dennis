defmodule Dennis.Donation do
  use Dennis.Web, :model

  alias Dennis.Repo
  alias Dennis.User
  alias Dennis.Mailer
  alias Commerce.Billing
  alias Commerce.Billing.Response, as: BillingResponse  

  schema "donations" do
    belongs_to :challenge, Dennis.Challenge

    field :transaction_token, :string
    field :authorization_token, :string
    field :miles_bought, :integer
    field :tip, :integer
    field :total_donated, :integer
    field :is_anonymous, :boolean, default: false
    field :name, :string, default: "Anonymous"
    field :destination_account, :string

    timestamps
  end

  @required_fields ~w(miles_bought total_donated transaction_token challenge_id)
  @optional_fields ~w(authorization_token name tip destination_account)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  defp total_donated(challenge, %{"miles_bought" => miles_bought}) do
    total = String.to_integer(miles_bought) * challenge.mile_price
    total
  end

  def charge_donation(challenge, donation_params, stripe_email) do
    donation_changeset =  changeset(%Dennis.Donation{
           challenge_id: challenge.id,
           total_donated: total_donated(challenge, donation_params)
        }, donation_params)

    if donation_changeset.valid? do
      case stripe_billing(challenge, donation_changeset, stripe_email) do
        {:ok, %BillingResponse{authorization: authorization_token}} ->
          donation = create!(challenge, donation_changeset, stripe_email, authorization_token)
          athlete = Repo.get_by(User, id: challenge.user_id)
          Mailer.thank_donor(athlete, stripe_email, challenge)
          {:ok, donation}

        {:error, %BillingResponse{reason: reason}} = error ->
          IO.puts ">>>>>> BILL ERR: #{inspect(error)}"
          {:error, reason, donation_changeset}
      end      
    else
      {:error, donation_changeset.errors, donation_changeset}
    end
  end

  defp create!(challenge, donation_changeset, stripe_email, authorization_token) do
    destination_account = get_destination_account(challenge, donation_changeset)
    Repo.insert! changeset(donation_changeset, %{
      authorization_token: authorization_token,
      destination_account: destination_account
    })
  end

  defp get_destination_account(challenge, donation_changeset) do
    cause_user = challenge.cause.user
    athlete = challenge.user
    race_fee = challenge.race_fee
    total_donated = get_field(donation_changeset, :total_donated)
    if challenge.will_redeem_fee do
      if can_athlete_redeem_fee?(challenge) do
        cond do
          virtual_amount_redeemed(challenge, athlete, donation_changeset) > race_fee ->
            cause_user.stripe_id
          virtual_amount_redeemed(challenge, athlete, donation_changeset) < race_fee ->
            athlete.stripe_id
        end
      else
        cause_user.stripe_id
      end
    else
      cause_user.stripe_id
    end
  end

  defp can_athlete_redeem_fee?(challenge) do
    amount_donated_to_challenge(challenge.id) > (challenge.race_fee * 6)
  end

  defp stripe_billing(challenge, donation_changeset, stripe_email) do
    import Ecto.Changeset, only: [get_field: 2]
    application_fee = Application.get_env(:dennis, :stripe)[:application_fee]
    destination_account = get_destination_account(challenge, donation_changeset)
    org_stripe_id = challenge.cause.user.stripe_id # not ruby, tho
    charge_description = "MYMYLES // #{challenge.name}"

    Billing.authorize(:stripe, 
      get_field(donation_changeset, :total_donated) * 100, # Stripe uses cents
      get_field(donation_changeset, :transaction_token), 
      capture: true,
      destination: destination_account,
      application_fee: application_fee,
      description: charge_description)
  end

  def amount_donated_to_challenge(challenge_id) do
    total = Dennis.Repo.one from donation in Dennis.Donation,
        where: donation.challenge_id == ^challenge_id,
        select: sum(donation.total_donated)
    total || 0
  end

  defp amount_redeemed(challenge, athlete_account) do
    total = Dennis.Repo.one from donation in Dennis.Donation,
    where: donation.challenge_id == ^challenge.id and donation.destination_account == ^athlete_account,
    select: sum(donation.total_donated)
    total || 0
  end

  defp virtual_amount_redeemed(challenge, athlete, donation_changeset) do
    amount_redeemed(challenge, athlete.stripe_id) + get_field(donation_changeset, :total_donated)
  end

end
