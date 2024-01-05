defmodule LiveNodeWeb.VideoLive.Index do
  use LiveNodeWeb, :live_view

  alias LiveNode.VideoDownload
  alias LiveNode.VideoDownload.Video

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :videos, VideoDownload.list_videos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Video")
    |> assign(:video, VideoDownload.get_video!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Videos")
    |> assign(:video, nil)
  end

  defp apply_action(socket, :new, params) do
    socket
    |> assign(:page_title, "New Video")
    |> assign_video_from_url(params)
    |> apply_url_from_params(params)
  end

  def assign_url_from_params(socket, %{"url" => url}) do
    decode_out = Base.url_decode64(url)
    video =
      case decode_out do
        # URL decoded successfully
        {:ok, u} -> %Video{url: (u)}
        # FAILURE
        _ -> %Video{}
      end

    socket
    |> assign(:video, video)
  end

  def assign_video_from_url(socket, _params) do
    # no url provided case
    socket
    |> assign(:video, %Video{})
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
  def handle_info({LiveNodeWeb.VideoLive.FormComponent, {:saved, video}}, socket) do
    {:noreply, stream_insert(socket, :videos, video)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    video = VideoDownload.get_video!(id)
    {:ok, _} = VideoDownload.delete_video(video)

    {:noreply, stream_delete(socket, :videos, video)}
  end
end
