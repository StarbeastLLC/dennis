defmodule Dennis.RegistrationView do
  use Dennis.Web, :view

  def cookie(conn, cookie_name) do
    conn.cookie[cookie_name]
  end
end
