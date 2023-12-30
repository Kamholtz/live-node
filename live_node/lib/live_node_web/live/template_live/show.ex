defmodule LiveNodeWeb.TemplateLive.Show do
  use LiveNodeWeb, :live_view

  alias LiveNode.Notetaking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:template, Notetaking.get_template!(id))}
  end

  defp page_title(:show), do: "Show Template"
  defp page_title(:edit), do: "Edit Template"
end
