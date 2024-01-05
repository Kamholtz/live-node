defmodule LiveNode.VideoDownloadFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveNode.VideoDownload` context.
  """

  @doc """
  Generate a video.
  """
  def video_fixture(attrs \\ %{}) do
    {:ok, video} =
      attrs
      |> Enum.into(%{
        duration_msecs: 42,
        status: :in_progress,
        title: "some title",
        url: "some url"
      })
      |> LiveNode.VideoDownload.create_video()

    video
  end
end
