defmodule LiveNodeWeb.LinkHTML do
  use LiveNodeWeb, :html 
  embed_templates "link_html/*"

  def index(assigns) do
    ~H"""
    Hello!
    """
  end

end
