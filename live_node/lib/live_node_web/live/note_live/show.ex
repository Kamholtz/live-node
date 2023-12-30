defmodule LiveNodeWeb.NoteLive.Show do
  use LiveNodeWeb, :live_view

  alias LiveNode.Notetaking

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect("HERE1")
    {:ok, 
      socket
      |> assign(:url, "FROM note_live/show.ex")}
  end

  @impl true
  def handle_params(%{"id" => id, "url" => url}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:note, Notetaking.get_note!(id))
     # |> assign(:url, url)
    }
  end

  defp page_title(:show), do: "Show Note"
  defp page_title(:edit), do: "Edit Note"
end
