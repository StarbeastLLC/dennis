defmodule Dennis.OrgView do
  use Dennis.Web, :view

  def tweet_cause(conn, cause) do
  	"https://twitter.com/intent/tweet?text=#{cause.name}&url=#{org_path(conn, :show_cause, cause)}"
  end
end