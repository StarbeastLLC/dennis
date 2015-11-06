defmodule Dennis.AdminPlug do

	import Plug.Conn
    use Phoenix.Controller
	
	alias Dennis.User


	def init(config) do
		config
	end

	def call(conn, config) do
		id = get_session(conn, :current_user)
		user = id && User.find_by_id(id)
		if user && user.is_admin do
		  conn
		else
		  conn
		  |> put_status(:forbidden)
		  |> text("permission denied")
		  |> halt
		end
	end

end