defmodule Dennis.DonationView do
  use Dennis.Web, :view

  def data_key do
  	Application.get_env(:dennis, :stripe)[:data_key]
  end

end