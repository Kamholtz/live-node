defmodule LiveNodeWeb.VideoLiveTest do
  alias LiveNodeWeb.YtDlp.Core
  use LiveNodeWeb.ConnCase, async: true


  # NOTE: works!
  test "system cmd yt-dlp --print-to-file json" do

    cmd = "yt-dlp"
    args = [
      "https://www.youtube.com/watch?v=R7t7zca8SyM", 
      "--simulate",

      "--output",
      "temp/video_%(title)s/%(title)s.%(ext)s",

      "--print-to-file", 
      "%()j",
      "temp/print-to-file.json"
    ]
    res = System.cmd(cmd, args) 
      # |> elem(0)
    IO.inspect(res, label: "res")

    assert true
  end

  test "split_cmd_out_lines" do
    out = Core.split_cmd_out_lines("1 \r 2 \n 3 \r\n   4")
    assert out = ["1", "2", "3", "4"]
  end

  test "update_state/1" do
    out = Core.update_state("2")
    assert(out = %{cmd_output_lines: ["2"]})

    # ["1"] ++ ["2"]

  end

  test "update_state/2" do
    out =
    Core.update_state("1")
    |> Core.update_state("2 \r3")

    assert(out = %{cmd_output_lines: ["1", "2", "3"]})
  end

  test "is_download_line?" do
    assert(Core.is_download_line?("[download] aaaa"))
  end

  test "get_latest_progress([])" do
    res = Core.get_latest_progress([])
    assert(res = 0)
  end

  test "get_latest_progress" do
    res = Core.get_latest_progress(["[download] 1", "[download 2]"])
    assert(res = "[download 2]")
  end

  test "update_state integration" do
    cmd_output_str = "[youtube] Extracting URL: https://www.youtube.com/watch?v=R7t7zca8SyM\n[youtube] R7t7zca8SyM: Downloading webpage\n[youtube] R7t7zca8SyM: Downloading
      ios player API JSON\n[youtube] R7t7zca8SyM: Downloading android player API JSON\n[youtube] R7t7zca8SyM: Downloading m3u8 information\n[info] R7t7zca8SyM: D
      ownloading 1 format(s): 22\n[info] Writing '%()j' to: temp\\print-to-file.json\n[download] Destination: Elixir in 100 Seconds [R7t7zca8SyM].mp4\n\r[download
      ]   0.0% of    4.41MiB at  499.56KiB/s ETA 00:09\r[download]   0.1% of    4.41MiB at  864.80KiB/s ETA 00:05\r[download]   0.2% of    4.41MiB at    1.97MiB/s
      ETA 00:02\r[download]   0.3% of    4.41MiB at    3.00MiB/s ETA 00:01\r[download]   0.7% of    4.41MiB at    2.07MiB/s ETA 00:02\r[download]   1.4% of    4.
      41MiB at    2.18MiB/s ETA 00:01\r[download]   2.8% of    4.41MiB at    1.45MiB/s ETA 00:02\r[download]   5.7% of    4.41MiB at    2.23MiB/s ETA 00:01\r[down
      load]  11.3% of    4.41MiB at    3.13MiB/s ETA 00:01\r[download]  22.7% of    4.41MiB at    3.69MiB/s ETA 00:00\r[download]  45.4% of    4.41MiB at    4.22M
      iB/s ETA 00:00\r[download]  90.8% of    4.41MiB at    4.98MiB/s ETA 00:00\r[download] 100.0% of    4.41MiB at    5.04MiB/s ETA 00:00\r[download] 100% of    
      4.41MiB in 00:00:01 at 4.37MiB/s   \n"    

    state = Core.update_state(cmd_output_str)

    IO.inspect(state, label: "state")

    assert(false)
  end


  test "get_progress_from_str" do
    out = Core.get_progress_from_str("abc 123")
    dbg(out)
    assert(out = [ "123" ])
  end



  # test "parse output" do
  #
  #   {out, result} = {"[youtube] Extracting URL: https://www.youtube.com/watch?v=R7t7zca8SyM\n[youtube] R7t7zca8SyM: Downloading webpage\n[youtube] R7t7zca8SyM: Downloading
  #   ios player API JSON\n[youtube] R7t7zca8SyM: Downloading android player API JSON\n[youtube] R7t7zca8SyM: Downloading m3u8 information\n[info] R7t7zca8SyM: D
  #   ownloading 1 format(s): 22\n[info] Writing '%()j' to: temp\\print-to-file.json\n[download] Destination: Elixir in 100 Seconds [R7t7zca8SyM].mp4\n\r[download
  #   ]   0.0% of    4.41MiB at  499.56KiB/s ETA 00:09\r[download]   0.1% of    4.41MiB at  864.80KiB/s ETA 00:05\r[download]   0.2% of    4.41MiB at    1.97MiB/s
  #   ETA 00:02\r[download]   0.3% of    4.41MiB at    3.00MiB/s ETA 00:01\r[download]   0.7% of    4.41MiB at    2.07MiB/s ETA 00:02\r[download]   1.4% of    4.
  #   41MiB at    2.18MiB/s ETA 00:01\r[download]   2.8% of    4.41MiB at    1.45MiB/s ETA 00:02\r[download]   5.7% of    4.41MiB at    2.23MiB/s ETA 00:01\r[down
  #   load]  11.3% of    4.41MiB at    3.13MiB/s ETA 00:01\r[download]  22.7% of    4.41MiB at    3.69MiB/s ETA 00:00\r[download]  45.4% of    4.41MiB at    4.22M
  #   iB/s ETA 00:00\r[download]  90.8% of    4.41MiB at    4.98MiB/s ETA 00:00\r[download] 100.0% of    4.41MiB at    5.04MiB/s ETA 00:00\r[download] 100% of    
  #   4.41MiB in 00:00:01 at 4.37MiB/s   \n",
  #   0}
  #
  #   split_strs = String.split(out, ["\n", "\r"])
  #
  #   Enum.filter()
  #
  #   case input do
  #     {_, 0} -> :success
  #   end
  # end
  


end
