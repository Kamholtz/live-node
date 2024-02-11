defmodule LiveNodeWeb.VideoLive.FormComponent do
  use LiveNodeWeb, :live_component

  alias LiveNode.VideoDownload
  alias LiveNodeWeb.YtDlp.Core

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage video records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="video-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:duration_msecs]} type="number" label="Duration msecs" />
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a value"
          options={Ecto.Enum.values(LiveNode.VideoDownload.Video, :status)}
        />
        <.input field={@form[:content_type]} type="text" label="Content type" />
        <.input field={@form[:video_path]} type="text" label="Video path" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Video</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{video: video} = assigns, socket) do
    changeset = VideoDownload.change_video(video)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"video" => video_params}, socket) do
    changeset =
      socket.assigns.video
      |> VideoDownload.change_video(video_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"video" => video_params}, socket) do
    save_video(socket, socket.assigns.action, video_params)
  end

  defp save_video(socket, :edit, video_params) do
    case VideoDownload.update_video(socket.assigns.video, video_params) do
      {:ok, video} ->
        notify_parent({:saved, video})

        {:noreply,
         socket
         |> put_flash(:info, "Video updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_video(socket, :new, video_params) do
    case VideoDownload.create_video(video_params) do
      {:ok, %{:url => url} = video} ->
        notify_parent({:saved, video})

        Core.download_url(url, %{opts: %{simulate: false}})
        |> case do
          # Update status and set video path
          %{latest_progress: x, destination: video_path} when x >= 100 ->
            {:ok,
              # TODO: remove hardcoded content_type and replace with the content type based on extension of the print-to-file.json
              VideoDownload.update_video(video, %{status: :success, video_path: Path.relative_to(video_path, "temp"), content_type: "video/mp4"})}

            _ -> {:error, {:ok, VideoDownload.update_video(video, %{status: :error})}}
        end
        |> IO.inspect

        {:noreply,
         socket
         |> put_flash(:info, "Video created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  def put_relative_video_path(video_attrs, %{destination_dir: nil} = video_download_state), do: video_attrs
  def put_relative_video_path(video_attrs, %{destination_dir: destination_dir} = video_download_state) do
    rel_path = Path.relative_to(destination_dir, "temp")
    video_attrs
    |> Map.put(:video_path, destination_dir)
  end

  defp download_video(url) do
    Core.download_url(url, %{opts: %{simulate: true}})
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
