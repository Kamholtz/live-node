defmodule LiveNodeWeb.TodoLive do
  # In Phoenix v1.6+ apps, the line is typically: use LiveNodeWeb, :live_view
  use Phoenix.LiveView
  alias VegaLite, as: Vl

  def mount(_params, _session, socket) do
    temperature = 70 # Let's assume a fixed temperature for now
    {:ok, 
      socket 
      |> assign(:temperature, temperature)
      |> assign(:cmd_results, [System.cmd("git", ["status"]) |> elem(0)])
      |> assign(:blocks_as_json, [get_block()] |> Jason.encode!)
      |> assign(:todos, get_todos())
    }
  end

  defp get_todos() do
    [
      %{title: "first",
        status: "in-progress"}
    ]
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

  def vega_lite_function_component(assigns) do
    data = [
      %{"category" => "A", "score" => 28},
      %{"category" => "B", "score" => 55}
    ]

    # plot = Vl.new()
    # |> Vl.data_from_values(data)
    # |> Vl.Export.to_html()

    # Initialize the specification, optionally with some top-level properties
    plot = Vl.new(width: 400, height: 400)
    # Specify data source for the graphic using one of the data_from_* functions
    |> Vl.data_from_values(iteration: 1..100, score: 1..100)
    # Pick a visual mark
    |> Vl.mark(:line)
    # Map data fields to visual properties of the mark, in this case point positions
    |> Vl.encode_field(:x, "iteration", type: :quantitative)
    |> Vl.encode_field(:y, "score", type: :quantitative)
    |> Vl.Export.to_html()

    ~H"""
    <div>
      <%= plot %>
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
