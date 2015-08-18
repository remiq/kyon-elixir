defmodule Placebooru.ActivityView do
  use Placebooru.Web, :view

  def prefix do
    %{file_prefix: file_prefix} = Application.get_env(:placebooru, :branding,
          %{file_prefix: "placebooru_"})
    file_prefix
  end
end
