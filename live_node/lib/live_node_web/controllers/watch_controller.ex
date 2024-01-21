defmodule LiveNodeWeb.WatchController do
  use LiveNodeWeb, :controller
  import LiveNodeWeb.Util
  alias LiveNode.Repo
  alias LiveNodeWeb.Video

  def show(%{req_headers: headers} = conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    send_video(conn, headers, video)
  end
end
