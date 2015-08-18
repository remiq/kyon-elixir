defmodule Placebooru.LayoutView do
  use Placebooru.Web, :view

  def title do
    %{title: title} = Application.get_env(:placebooru, :branding, %{title: "Default title"})
    title
  end
end
