defmodule Dennis.OrgController do
	use Dennis.Web, :controller 

	def show(conn, _params) do
		text conn, "I'm a mighty org"
	end
	
end