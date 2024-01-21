defmodule LiveNodeWeb.Util do
  def build_video_path(video) do
    Application.get_env(:phoenix_video_stream, :uploads_dir) |> Path.join(video.path)
  end

  # NOTE: Confirmed send_video belongs here
  def send_video(conn, headers, video) do
    video_path = build_video_path(video)
    out = conn
    |> Plug.Conn.put_resp_header("content-type", ("video" || video.content_type))
    |> Plug.Conn.send_file(200, ("/home/carlk/repos/live-node/live_node/temp/video_Elixir in 100 Seconds/Elixir in 100 Seconds.mp4" || video_path))

    out
  end
end
