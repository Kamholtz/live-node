defmodule LiveNodeWeb.VideoController do
  import LiveNodeWeb.Util, only: [build_video_path: 1]

  # def create(conn, %{"video" => video_params}) do
  #   changeset = Video.changeset(%Video{}, video_params)
  #   case Repo.insert(changeset) do
  #     {:ok, video} ->
  #       persist_file(video, video_params["video_file"])
  #
  #       conn
  #       |> put_flash(:info, "Video created successfully.")
  #       |> redirect(to: video_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end
end
