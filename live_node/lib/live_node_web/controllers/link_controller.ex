defmodule LiveNodeWeb.LinkController do
  use LiveNodeWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"url" => url}) do
    render(conn, :show, url: url)
  end
end
