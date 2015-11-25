defmodule Dennis.OrgView do
  use Dennis.Web, :view

  alias Dennis.States

  def us_states do
    States.us_states
  end

  def tweet_cause(conn, cause) do
  	"https://twitter.com/intent/tweet?text=#{cause.name}&url=#{org_path(conn, :show_cause, cause)}"
  end

  def cause_photo_urls(cause) do
  	  [cause.photo1, cause.photo2, cause.photo3, cause.photo4, cause.photo5]
  	  |> Enum.reject(fn photo -> !photo end)
  	  |> Enum.map(fn photo ->
  	  	Dennis.CausePhoto.url({photo, cause})
  	  end)
  end
  
end