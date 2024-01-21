defmodule LiveNodeWeb.Util do
  def build_video_path(video) do
    Application.get_env(:phoenix_video_stream, :uploads_dir) |> Path.join(video.path)
  end


  def get_offset(headers) do
    case List.keyfind(headers, "range", 0) do
      {"range", "bytes=" <> start_pos} ->
        String.split(start_pos, "-") |> hd |> String.to_integer
      nil ->
        0
    end
  end

  def get_file_size(path) do
    {:ok, %{size: size}} = File.stat path

    size
  end

  # NOTE: Confirmed send_video belongs here
  def send_video(conn, _headers, video) do
    video_path = build_video_path(video)
    out = conn

    # TODO: remove hardcoded content-type
    |> Plug.Conn.put_resp_header("content-type", "video/mp4")
    |> Plug.Conn.send_file(200, "/home/carlk/repos/live-node/live_node/temp/video_Elixir in 100 Seconds/Elixir in 100 Seconds.mp4")

    out
  end
end
