defmodule LiveNodeWeb.LinkHTML do
  use LiveNodeWeb, :html 
  embed_templates "link_html/*"

  # this route is overridden by the heex file: lib/live_node_web/controllers/link_html/index.html.heex
  def _index(assigns) do
    ~H"""
    Hello!
    """
  end
end
