defmodule Dennis.AthleteController do
	use Dennis.Web, :controller

	def show(conn, _params) do
		text conn, "Soy un poderoso atleta"
	end
	
end