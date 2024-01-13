defmodule LiveNodeWeb.YtDlp.Core do

  def download_url(url, %{"opts" => %{"simulate" => simulate?}}) do
    cmd = "yt-dlp"
    args = [
      url, 

      # prevent downloading video
      case simulate? do
        true -> "--simulate"
        _ -> nil
      end,

      "--output",
      "temp/video_%(title)s/%(title)s.%(ext)s",

      "--print-to-file", 
      "%()j",
      "temp/print-to-file.json"
    ]
    res = System.cmd(cmd, args) 
  end

  def update_state(cmd_output_str) do
    update_state(%{cmd_output_lines: []}, cmd_output_str)
    |> dbg
  end

  def update_state(state, cmd_output_str) do
    # handle initial case where state is nil
    (state || %{cmd_output_lines: []})
    |> update_in([:cmd_output_lines], fn lines -> lines ++ split_cmd_out_lines(cmd_output_str) end)
    |> put_latest_download_line

  end

  def update_latest_progress(%{:cmd_output_lines => lines} = state) do
    # download_lines = lines
    # |> Enum.filter(&is_download_line?/1)

    state
    |> Map.put(:latest_progress, get_latest_progress(lines))
  end

  def put_latest_download_line(%{:cmd_output_lines => lines} = state) do
    state
    |> Map.put(:latest_progress_line, get_latest_progress_line(lines))
  end

  def get_latest_progress_line(lines) do
    latest_download_line = lines
    |> Enum.filter(&is_download_line?/1)
    |> Enum.at(-1)

    latest_download_line
  end

  def get_latest_progress([]) do
    # no lines, must be at 0% progress
    0
  end

  def get_latest_progress(lines) do
    latest_download_line = lines
    |> Enum.filter(&is_download_line?/1)
    |> Enum.at(-1)

    0.1
  end


  def get_progress_from_str(line) do
    out = Regex.run(~r/\d+/, line)
    out
  end

  def is_download_line?(line) do
    # String.match?("bar", ~r/foo/)
    String.match?(line, ~r/^\[download\]/)
  end

  def split_cmd_out_lines(cmd_output_str) do
    String.split(cmd_output_str, ["\r", "\n"], trim: true)
  end

# {"[youtube] Extracting URL: https://www.youtube.com/watch?v=R7t7zca8SyM\n[youtube] R7t7zca8SyM: Downloading webpage\n[youtube] R7t7zca8SyM: Downloading
#  ios player API JSON\n[youtube] R7t7zca8SyM: Downloading android player API JSON\n[youtube] R7t7zca8SyM: Downloading m3u8 information\n[info] R7t7zca8SyM: D
# ownloading 1 format(s): 22\n[info] Writing '%()j' to: temp\\print-to-file.json\n[download] Destination: Elixir in 100 Seconds [R7t7zca8SyM].mp4\n\r[download
# ]   0.0% of    4.41MiB at  499.56KiB/s ETA 00:09\r[download]   0.1% of    4.41MiB at  864.80KiB/s ETA 00:05\r[download]   0.2% of    4.41MiB at    1.97MiB/s
#  ETA 00:02\r[download]   0.3% of    4.41MiB at    3.00MiB/s ETA 00:01\r[download]   0.7% of    4.41MiB at    2.07MiB/s ETA 00:02\r[download]   1.4% of    4.
# 41MiB at    2.18MiB/s ETA 00:01\r[download]   2.8% of    4.41MiB at    1.45MiB/s ETA 00:02\r[download]   5.7% of    4.41MiB at    2.23MiB/s ETA 00:01\r[down
# load]  11.3% of    4.41MiB at    3.13MiB/s ETA 00:01\r[download]  22.7% of    4.41MiB at    3.69MiB/s ETA 00:00\r[download]  45.4% of    4.41MiB at    4.22M
# iB/s ETA 00:00\r[download]  90.8% of    4.41MiB at    4.98MiB/s ETA 00:00\r[download] 100.0% of    4.41MiB at    5.04MiB/s ETA 00:00\r[download] 100% of    
# 4.41MiB in 00:00:01 at 4.37MiB/s   \n",
#  0}
  #


end
