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

  @impl true
  def update(_, socket) do
    spec =
      VegaLite.new(title: "Demo", width: :container, height: :container, padding: 5)
      # Load values. Values are a map with the attributes to be used by Vegalite
      |> VegaLite.data_from_values(fake_data())
      # Defines the type of mark to be used
      |> VegaLite.mark(:line)
      # Sets the axis, the key for the data and the type of data
      |> VegaLite.encode_field(:x, "date", type: :nominal)
      |> VegaLite.encode_field(:y, "total", type: :quantitative)
      # Output the specifcation
      |> VegaLite.to_spec()

    socket = assign(socket, id: socket.id)
    {:ok, push_event(socket, "vega_lite:#{socket.id}:init", %{"spec" => spec})}
  end

  defp fake_data do
    today = Date.utc_today()
    until = today |> Date.add(10)

    Enum.map(Date.range(today, until), fn date ->
      %{total: Enum.random(1..100), date: Date.to_iso8601(date), name: "potato"}
    end)
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
