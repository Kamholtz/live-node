defmodule LiveNodeWeb.VideoLiveTest do
  use LiveNodeWeb.ConnCase, async: true

    # -o, --output [TYPES:]TEMPLATE   Output filename template; see "OUTPUT
    #                                 TEMPLATE" for details
  
  # Additionally, you can set different output templates for the various metadata 
  # files separately from the general output template by specifying the type of 
  # file followed by the template separated by a colon `:`. The different file 
  # types supported are `subtitle`, `thumbnail`, `description`, `annotation` (deprecated), `infojson`, `link`, `pl_thumbnail`, `pl_description`, `pl_infojson`, `chapter`, `pl_video`. E.g. `-o "%(title)s.%(ext)s" -o "thumbnail:%(title)s\%(title)s.%(ext)s"`  will put the thumbnails in a folder with the same name as the video. If any of the templates is empty, that type of file will not be written. E.g. `--write-thumbnail -o "thumbnail:"` will write thumbnails only for playlists and not for video.


    # --use-postprocessor NAME[:ARGS]
    #                                 The (case sensitive) name of plugin
    #                                 postprocessors to be enabled, and
    #                                 (optionally) arguments to be passed to it,
    #                                 separated by a colon ":". ARGS are a
    #                                 semicolon ";" delimited list of NAME=VALUE.
    #                                 The "when" argument determines when the
    #                                 postprocessor is invoked. It can be one of
    #                                 "pre_process" (after video extraction),
    #                                 "after_filter" (after video passes filter),
    #                                 "video" (after --format; before
    #                                 --print/--output), "before_dl" (before each
    #                                 video download), "post_process" (after each
    #                                 video download; default), "after_move"
    #                                 (after moving video file to it's final
    #                                 locations), "after_video" (after downloading
    #                                 and processing all formats of a video), or
    #                                 "playlist" (at end of playlist). This option
    #                                 can be used multiple times to add different
    #                                 postprocessors

    # -O, --print [WHEN:]TEMPLATE     Field name or output template to print to
    #                                 screen, optionally prefixed with when to
    #                                 print it, separated by a ":". Supported
    #                                 values of "WHEN" are the same as that of
    #                                 --use-postprocessor (default: video).
    #                                 Implies --quiet. Implies --simulate unless
    #                                 --no-simulate or later stages of WHEN are
    #                                 used. This option can be used multiple times
    # --print-to-file [WHEN:]TEMPLATE FILE
    #                                 Append given template to the file. The
    #                                 values of WHEN and TEMPLATE are same as that
    #                                 of --print. FILE uses the same syntax as the
    #                                 output template. This option can be used
    #                                 multiple times
    # -j, --dump-json                 Quiet, but print JSON information for each
    #                                 video. Simulate unless --no-simulate is
    #                                 used. See "OUTPUT TEMPLATE" for a
    #                                 description of available keys
    # -J, --dump-single-json          Quiet, but print JSON information for each
    #                                 url or infojson passed. Simulate unless
    #                                 --no-simulate is used. If the URL refers to
    #                                 a playlist, the whole playlist information
    #                                 is dumped in a single line

  test "system cmd yt-dlp" do

    cmd = "yt-dlp"
    args = [
      "https://www.youtube.com/watch?v=R7t7zca8SyM", 
      "--dump-json", 
      "--simulate",
    ]
    res = System.cmd(cmd, args) 
      # |> elem(0)
    # IO.inspect(res, label: "res")

    assert true
  end

  test "system cmd yt-dlp --print formats_table" do

    cmd = "yt-dlp"
    args = [
      "https://www.youtube.com/watch?v=R7t7zca8SyM", 
      "--simulate", 

      # will note appear
      "--output",
      "formats.txt",

      "--print", 
      "formats_table",
    ]
    res = System.cmd(cmd, args) 
      # |> elem(0)
    IO.inspect(res, label: "res")

    assert true
  end

  test "system cmd yt-dlp --output description" do

    cmd = "yt-dlp"
    args = [
      "https://www.youtube.com/watch?v=R7t7zca8SyM", 
      "--simulate", 

      "--output",
      "temp/video_%(title)s/%(title)s.%(ext)s",
      # "--output",
      # "description:description_%(title)s\%(title)s.%(ext)s",
      # "--output",
      # "infojson:infojson_%(title)s\%(title)s.%(ext)s",
      # "--output",
      # "link:link_%(title)s\%(title)s.%(ext)s",

      # check that simple format doesn't work either?
      "--output",
      "description:output_description",
      "--output",
      "infojson:output_infojson",
      "--output",
      "link:output_link",
    ]
    res = System.cmd(cmd, args) 
      # |> elem(0)
    IO.inspect(res, label: "res")

# res: {"[youtube] Extracting URL: https://www.youtube.com/watch?v=R7t7zca8SyM\n[youtube] R7t7zca8SyM: Downloading webpage\n[youtube] R7t7zca8SyM: Downloading ios player API JSON\n[youtube] R7
# t7zca8SyM: Downloading android player API JSON\n[youtube] R7t7zca8SyM: Downloading m3u8 information\n[info] R7t7zca8SyM: Downloading 1 format(s): 22\n[download] video_Elixir in 100 Seconds\\
# Elixir in 100 Seconds.mp4 has already been downloaded\n\r[download] 100% of    4.41MiB\n",
 # 0}

    assert false
  end


  # NOTE: works!
  test "system cmd yt-dlp --print-to-file json" do

    cmd = "yt-dlp"
    args = [
      "https://www.youtube.com/watch?v=R7t7zca8SyM", 
      "--simulate",
      "--print-to-file", 
      "%()j",
      "temp/print-to-file.json"
    ]
    res = System.cmd(cmd, args) 
      # |> elem(0)
    # IO.inspect(res, label: "res")

    assert true
  end
end
