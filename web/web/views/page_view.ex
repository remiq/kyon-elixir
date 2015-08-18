defmodule Placebooru.PageView do
  use Placebooru.Web, :view

  def main_page do
    %{main_page: content} = Application.get_env(:placebooru, :branding, 
      %{main_page: "Default content"})
    # we return HTML, so we have to mark it as safe, or it will be sanitized
    {:safe, Earmark.to_html(content)}
  end
end
