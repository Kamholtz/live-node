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
    |> apply_url_from_params(_params)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notes")
    |> assign(:note, nil)
    |> apply_url_from_params(_params)
  end

  defp apply_url_from_params(socket, %{"url" => url}) do
    # TODO: receive base 64 encoded URL, then change to regulat string
    IO.inspect(url, label: "url received: ")
    socket
    |> assign(:url, url)
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

# url_encode64(data, opts \\ [])View Source
# @spec url_encode64(binary(), keyword()) :: binary()
# Encodes a binary string into a base 64 encoded string with URL and filename safe alphabet.
#
# Accepts padding: false option which will omit padding from the output string.
#
# Examples
# iex> Base.url_encode64(<<255, 127, 254, 252>>)
# "_3_-_A=="
#
# iex> Base.url_encode64(<<255, 127, 254, 252>>, padding: false)
# "_3_-_A"

  def test() do
    data = "www.abc.com"
    opts = []
    encoded = Base.url_encode64(data, opts)
    decoded = Base.url_decode64(encoded, opts)
    [data, encoded, decoded]
end

end


# LiveNodeWeb.NoteLive.Index.test()
