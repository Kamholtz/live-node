defmodule LiveNodeWeb.ThermostatLive do
  # In Phoenix v1.6+ apps, the line is typically: use LiveNodeWeb, :live_view
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    Current temperature: <%= @temperature %>°F
    <button phx-click="inc_temperature" style="background-color:green">+</button>

    <br>

    <h1>
      TODO:
    </h1>
    
    - [x] How to send cmd + return output to webpage
    <div>
      <h2>Example of using `System.cmd(...)`</h2>
      <span>Git status: </span><span><%= @git_status %></span>
    </div>
    <br>

    - [ ] how to render a collection of `blocks` on the page with particular x,y positions
    <div>
      <span>blocks: </span><span><%= @blocks %></span>
    </div>


    - [ ] drag and drop blocks, and assign that new value to the socket

    - [ ] get text from textbox into `handle_event("run_cmd")`

    """
  end

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
