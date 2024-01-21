defmodule LiveNodeWeb.WatchController do
  use LiveNodeWeb, :controller
  import LiveNodeWeb.Util
  alias LiveNode.Repo
  alias LiveNodeWeb.Video

  def show(%{req_headers: headers} = conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    send_video(conn, headers, video)
  end

  # def send_video(conn, headers, video) do
  #   video_path = build_video_path(video)
  #   out = conn
  #   |> Plug.Conn.put_resp_header("content-type", ("video" || video.content_type))
  #   |> Plug.Conn.send_file(200, ("/home/carlk/repos/live-node/live_node/temp/video_Elixir in 100 Seconds/Elixir in 100 Seconds.mp4" || video_path))
  #
  #   out
  # end
end
