defmodule Dennis.CauseView do
  use Dennis.Web, :view

  def tweet_cause(conn, cause) do
  	"https://twitter.com/intent/tweet?text=#{cause.name}&url=#{org_path(conn, :show_cause, cause)}"
  end

  def avatar_url(user) do
    Dennis.Avatar.url({user.avatar, user})
  end

  def photo_url(cause) do
    Dennis.CausePhoto.url({cause.photo1, cause})
  end

  def cause_support_photos(cause) do
    cause
    |> Map.take([:photo2, :photo3, :photo4])
    |> Map.values
    |> Enum.filter(fn p -> p end)
    |> Enum.map(fn p -> Dennis.CausePhoto.url({p, cause}) end)
  end

  def parse_video_url(watch_url) do
    [video_id] = String.split watch_url, "https://www.youtube.com/watch?v=", trim: true
    "https://youtube.com/embed/" <> video_id
  end

  def cause_main_photo(cause) do
    if cause.photo1 do
      Dennis.CausePhoto.url({cause.photo1, cause})
    else
      "/images/c1.jpg"
    end
  end
end
