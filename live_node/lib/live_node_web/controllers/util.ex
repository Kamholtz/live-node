defmodule LiveNodeWeb.Util do
  def build_video_path(video) do
    Application.get_env(:live_node, :uploads_dir) |> Path.join(video.path)
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
    video_path =
    video
      |> Map.put(:path, video.video_path || "video_Elixir in 100 Seconds/Elixir in 100 Seconds.mp4")
      |> build_video_path()

    # TODO: remove hardcoded content-type
    out = conn
    |> Plug.Conn.put_resp_header("content-type", video.content_type)
    |> Plug.Conn.send_file(200, video_path)
    out
  end
end
