defmodule LiveNodeWeb.NoteLive.Index do
  use LiveNodeWeb, :live_view

  alias LiveNode.Notetaking
  alias LiveNode.Notetaking.Note

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :notes, Notetaking.list_notes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Note")
    |> assign(:note, Notetaking.get_note!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Note")
    |> assign(:note, %Note{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notes")
    |> assign(:note, nil)
  end

  @impl true
  def handle_info({LiveNodeWeb.NoteLive.FormComponent, {:saved, note}}, socket) do
    {:noreply, stream_insert(socket, :notes, note)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    note = Notetaking.get_note!(id)
    {:ok, _} = Notetaking.delete_note(note)

    {:noreply, stream_delete(socket, :notes, note)}
  end
end
