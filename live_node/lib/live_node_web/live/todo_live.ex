defmodule LiveNodeWeb.TodoLive do
  # In Phoenix v1.6+ apps, the line is typically: use LiveNodeWeb, :live_view
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    temperature = 70 # Let's assume a fixed temperature for now
    {:ok, 
      socket 
      |> assign(:temperature, temperature)
      |> assign(:cmd_results, [System.cmd("git", ["status"]) |> elem(0)])
      |> assign(:blocks, [get_block] |> Jason.encode!)
    }
  end

  defp get_block() do
    %{prop: "value"}
  end

  def example_function_component(assigns) do
    ~H"""
    <div style="background:blue; padding:5" >
      <h2><%= @text %>, input_number = <%= @input_number %></h2>
      <input type="text" value="initial text"/>
    </div>
    """
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end


  def handle_event("run_cmd", _params, socket) do
    {:noreply, update(socket, :cmd_results, &([get_cmd_result("git", ["status"]) | &1]))}
  end

  defp get_cmd_result(cmd, args) do
    System.cmd(cmd, args) |> elem(0)
  end
end
