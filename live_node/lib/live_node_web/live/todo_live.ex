defmodule LiveNodeWeb.TodoLive do
  # In Phoenix v1.6+ apps, the line is typically: use LiveNodeWeb, :live_view
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    temperature = 70 # Let's assume a fixed temperature for now
    {:ok, 
      socket 
      |> assign(:temperature, temperature)
      |> assign(:git_status, System.cmd("git", ["status"]) |> elem(0))
      |> assign(:blocks, [get_block] |> Jason.encode!)
    }
  end

  defp get_block() do
    %{prop: "value"}
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end
end