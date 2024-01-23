defmodule LiveNodeWeb.WatchController do
  use LiveNodeWeb, :controller
  import LiveNodeWeb.Util

  alias LiveNode.VideoDownload;
  alias LiveNodeWeb.Video

  def show(%{req_headers: headers} = conn, %{"id" => id}) do
    video = VideoDownload.get_video!(id)
    send_video(conn, headers, video)
  end
end
