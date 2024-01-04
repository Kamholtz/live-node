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
  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Note")
    |> assign_note_from_url(_params)
    |> apply_url_from_params(_params)
  end

  def assign_note_from_url(socket, %{"url" => url}) do
    decode_out = Base.url_decode64(url)
    note =
      case decode_out do
        # URL decoded successfully, return it wrapped in front matter fence
        {:ok, u} -> %Note{content: ("---\r\nurl: #{u}\r\n---\r\n")}
        # FAILURE
        {_, _} -> %Note{}
      end

    socket
    |> assign(:note, note)
  end

  def assign_note_from_url(socket, _params) do
    socket
    |> assign(:note, %Note{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notes")
    |> assign(:note, nil)
    |> apply_url_from_params(_params)
  end

  defp apply_url_from_params(socket, %{"url" => url}) do
    IO.inspect(url, label: "url received: ")
    decoded_url = Base.url_decode64(url)

    case decoded_url do
      {:ok, u} -> socket
        |> assign(:url, u)
      {_, _} -> socket 
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

  def test_encode_decode() do
    data = "www.abc.com"
    opts = []
    encoded = Base.url_encode64(data, opts)
    decoded = Base.url_decode64(encoded, opts)
    %{ input_url: data, encoded_url: encoded, decoded_url: decoded }
  end

  def _never() do 

    LiveNodeWeb.NoteLive.Index.test_encode_decode()

  end

end


# LiveNodeWeb.NoteLive.Index.test()
