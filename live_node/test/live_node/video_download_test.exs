defmodule LiveNode.VideoDownloadTest do
  use LiveNode.DataCase

  alias LiveNode.VideoDownload

  describe "videos" do
    alias LiveNode.VideoDownload.Video

    import LiveNode.VideoDownloadFixtures

    @invalid_attrs %{duration_msecs: nil, status: nil, title: nil, url: nil}

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert VideoDownload.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert VideoDownload.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      valid_attrs = %{duration_msecs: 42, status: :in_progress, title: "some title", url: "some url"}

      assert {:ok, %Video{} = video} = VideoDownload.create_video(valid_attrs)
      assert video.duration_msecs == 42
      assert video.status == :in_progress
      assert video.title == "some title"
      assert video.url == "some url"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = VideoDownload.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      update_attrs = %{duration_msecs: 43, status: :success, title: "some updated title", url: "some updated url"}

      assert {:ok, %Video{} = video} = VideoDownload.update_video(video, update_attrs)
      assert video.duration_msecs == 43
      assert video.status == :success
      assert video.title == "some updated title"
      assert video.url == "some updated url"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = VideoDownload.update_video(video, @invalid_attrs)
      assert video == VideoDownload.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = VideoDownload.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> VideoDownload.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = VideoDownload.change_video(video)
    end
  end
end
