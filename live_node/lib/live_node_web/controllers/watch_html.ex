defmodule LiveNodeWeb.WatchHTML do
  use LiveNodeWeb, :html

  embed_templates "watch_html/*"

  def watch_path(a, b, c) do
    # temp, to stop error
    "temp/video_arduino/arduino.mp4"
  end
end
