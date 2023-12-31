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

  # TODO: what is apply action?
  defp apply_action(socket, :new, params) do
    socket
    |> assign(:page_title, "New Note")
    |> assign_note_from_url(params)
    |> apply_url_from_params(params)
  end

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Notes")
    |> assign(:note, nil)
    |> apply_url_from_params(params)
  end


  def assign_note_from_url(socket, %{"url" => url}) do
    decode_out = Base.url_decode64(url)
    note =
      case decode_out do
        # URL decoded successfully, return it wrapped in front matter fence
        {:ok, u} -> %Note{content: ("---\r\nurl: #{u}\r\n---\r\n")}
        # FAILURE
        _ -> %Note{}
      end

    socket
    |> assign(:note, note)
  end

  def assign_note_from_url(socket, _params) do
    socket
    |> assign(:note, %Note{})
  end

  defp apply_url_from_params(socket, %{"url" => url}) do
    IO.inspect(url, label: "url received: ")
    decoded_url = Base.url_decode64(url)

    case decoded_url do
      {:ok, u} -> socket
        |> assign(:url, u)
      _ -> socket 
        |> assign(:url, "")
    end
  end

  defp apply_url_from_params(socket, _params) do
    socket
    |> assign(:url, nil)
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
