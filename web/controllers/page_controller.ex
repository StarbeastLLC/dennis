defmodule Dennis.PageController do
  use Dennis.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
