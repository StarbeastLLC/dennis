defmodule Dennis.Avatar do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  use Arc.Ecto.Definition

  @versions [:original]

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
     ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:original, _) do
    {:convert, "-gravity Center -resize 250x250^ -crop 250x250+0+0\! -limit area 10MB -limit disk 100MB -format png"}
  end

  # Override the persisted filenames:
  def filename(version, {file, scope}) do
    scope.email
  end

  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    "user/avatars"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
end
