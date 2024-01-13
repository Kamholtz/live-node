defmodule LiveNodeWeb.VegaLiteAggregateDemo do
  use LiveNodeWeb, :live_component

  @impl true
  def update(_, socket) do
    spec =
      VegaLite.new(title: "Demo2", width: :container, height: :container, padding: 5)
      # Load values. Values are a map with the attributes to be used by Vegalite
      |> VegaLite.data_from_values(fake_data())
      # Defines the type of mark to be used
      |> VegaLite.mark(:bar)
      # Sets the axis, the key for the data and the type of data
      |> VegaLite.encode_field(:x, "date", type: :nominal)
      |> VegaLite.encode_field(:y, "energy_produced", aggregate: "average", type: :quantitative)
      # Output the specifcation
      |> VegaLite.to_spec()

# {
#   "data": {
#     "values": [
#       {"a": "C", "b": 2}, {"a": "C", "b": 7}, {"a": "C", "b": 4},
#       {"a": "D", "b": 1}, {"a": "D", "b": 2}, {"a": "D", "b": 6},
#       {"a": "E", "b": 8}, {"a": "E", "b": 4}, {"a": "E", "b": 7}
#     ]
#   },
#   "mark": "bar",
#   "encoding": {
#     "x": {"field": "a", "type": "nominal"},
#     "y": {"aggregate": "average", "field": "b", "type": "quantitative"}
#   }
# }

    socket = assign(socket, id: socket.id)
    {:ok, push_event(socket, "vega_lite:#{socket.id}:init", %{"spec" => spec})}
  end

  @impl true
  def render(assigns) do
    # Here we have the element that will load the embedded view. Special note to data-id which is the
    # identifier that will be used by the hooks to understand which socket sent want.

    # We also identify the hook that will use this component using phx-hook.
    # Refer again to https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook
    ~H"""
    <div style="width:80%; height: 1000px" id="graph2" phx-hook="VegaLite" phx-update="ignore" data-id={@id}/>
    """
  end

  def fake_data() do

    raw_data =
    [
      %{ date: "04/13/2022T00:00", energy_produced: 0 },
      %{ date: "04/13/2022T00:15", energy_produced: 0 },
      %{ date: "04/13/2022T00:30", energy_produced: 0 },
      %{ date: "04/13/2022T00:45", energy_produced: 0 },
      %{ date: "04/13/2022T01:00", energy_produced: 0 },
      %{ date: "04/13/2022T01:15", energy_produced: 0 },
      %{ date: "04/13/2022T01:30", energy_produced: 0 },
      %{ date: "04/13/2022T01:45", energy_produced: 0 },
      %{ date: "04/13/2022T02:00", energy_produced: 0 },
      %{ date: "04/13/2022T02:15", energy_produced: 0 },
      %{ date: "04/13/2022T02:30", energy_produced: 0 },
      %{ date: "04/13/2022T02:45", energy_produced: 0 },
      %{ date: "04/13/2022T03:00", energy_produced: 0 },
      %{ date: "04/13/2022T03:15", energy_produced: 0 },
      %{ date: "04/13/2022T03:30", energy_produced: 0 },
      %{ date: "04/13/2022T03:45", energy_produced: 0 },
      %{ date: "04/13/2022T04:00", energy_produced: 0 },
      %{ date: "04/13/2022T04:15", energy_produced: 0 },
      %{ date: "04/13/2022T04:30", energy_produced: 0 },
      %{ date: "04/13/2022T04:45", energy_produced: 0 },
      %{ date: "04/13/2022T05:00", energy_produced: 0 },
      %{ date: "04/13/2022T05:15", energy_produced: 0 },
      %{ date: "04/13/2022T05:30", energy_produced: 0 },
      %{ date: "04/13/2022T05:45", energy_produced: 0 },
      %{ date: "04/13/2022T06:00", energy_produced: 1 },
      %{ date: "04/13/2022T06:15", energy_produced: 3 },
      %{ date: "04/13/2022T06:30", energy_produced: 7 },
      %{ date: "04/13/2022T06:45", energy_produced: 8 },
      %{ date: "04/13/2022T07:00", energy_produced: 2 },
      %{ date: "04/13/2022T07:15", energy_produced: 8 },
      %{ date: "04/13/2022T07:30", energy_produced: 2 },
      %{ date: "04/13/2022T07:45", energy_produced: 3 },
      %{ date: "04/13/2022T08:00", energy_produced: 0 },
      %{ date: "04/13/2022T08:15", energy_produced: 3 },
      %{ date: "04/13/2022T08:30", energy_produced: 7 },
      %{ date: "04/13/2022T08:45", energy_produced: 6 },
      %{ date: "04/13/2022T09:00", energy_produced: 7 },
      %{ date: "04/13/2022T09:15", energy_produced: 0 },
      %{ date: "04/13/2022T09:30", energy_produced: 9 },
      %{ date: "04/13/2022T09:45", energy_produced: 5 },
      %{ date: "04/13/2022T10:00", energy_produced: 5 },
      %{ date: "04/13/2022T10:15", energy_produced: 4 },
      %{ date: "04/13/2022T10:30", energy_produced: 8 },
      %{ date: "04/13/2022T10:45", energy_produced: 2 },
      %{ date: "04/13/2022T11:00", energy_produced: 0 },
      %{ date: "04/13/2022T11:15", energy_produced: 9 },
      %{ date: "04/13/2022T11:30", energy_produced: 4 },
      %{ date: "04/13/2022T11:45", energy_produced: 2 },
      %{ date: "04/13/2022T12:00", energy_produced: 1 },
      %{ date: "04/13/2022T12:15", energy_produced: 4 },
      %{ date: "04/13/2022T12:30", energy_produced: 5 },
      %{ date: "04/13/2022T12:45", energy_produced: 5 },
      %{ date: "04/13/2022T13:00", energy_produced: 4 },
      %{ date: "04/13/2022T13:15", energy_produced: 2 },
      %{ date: "04/13/2022T13:30", energy_produced: 3 },
      %{ date: "04/13/2022T13:45", energy_produced: 2 },
      %{ date: "04/13/2022T14:00", energy_produced: 0 },
      %{ date: "04/13/2022T14:15", energy_produced: 4 },
      %{ date: "04/13/2022T14:30", energy_produced: 9 },
      %{ date: "04/13/2022T14:45", energy_produced: 1 },
      %{ date: "04/13/2022T15:00", energy_produced: 1 },
      %{ date: "04/13/2022T15:15", energy_produced: 8 },
      %{ date: "04/13/2022T15:30", energy_produced: 6 },
      %{ date: "04/13/2022T15:45", energy_produced: 3 },
      %{ date: "04/13/2022T16:00", energy_produced: 7 },
      %{ date: "04/13/2022T16:15", energy_produced: 0 },
      %{ date: "04/13/2022T16:30", energy_produced: 9 },
      %{ date: "04/13/2022T16:45", energy_produced: 4 },
      %{ date: "04/13/2022T17:00", energy_produced: 5 },
      %{ date: "04/13/2022T17:15", energy_produced: 9 },
      %{ date: "04/13/2022T17:30", energy_produced: 0 },
      %{ date: "04/13/2022T17:45", energy_produced: 0 },
      %{ date: "04/13/2022T18:00", energy_produced: 0 },
      %{ date: "04/13/2022T18:15", energy_produced: 0 },
      %{ date: "04/13/2022T18:30", energy_produced: 0 },
      %{ date: "04/13/2022T18:45", energy_produced: 0 },
      %{ date: "04/13/2022T19:00", energy_produced: 0 },
      %{ date: "04/13/2022T19:15", energy_produced: 0 },
      %{ date: "04/13/2022T19:30", energy_produced: 0 },
      %{ date: "04/13/2022T19:45", energy_produced: 0 },
      %{ date: "04/13/2022T20:00", energy_produced: 0 },
      %{ date: "04/13/2022T20:15", energy_produced: 0 },
      %{ date: "04/13/2022T20:30", energy_produced: 0 },
      %{ date: "04/13/2022T20:45", energy_produced: 0 },
      %{ date: "04/13/2022T21:00", energy_produced: 0 },
      %{ date: "04/13/2022T21:15", energy_produced: 0 },
      %{ date: "04/13/2022T21:30", energy_produced: 0 },
      %{ date: "04/13/2022T21:45", energy_produced: 0 },
      %{ date: "04/13/2022T22:00", energy_produced: 0 },
      %{ date: "04/13/2022T22:15", energy_produced: 0 },
      %{ date: "04/13/2022T22:30", energy_produced: 0 },
      %{ date: "04/13/2022T22:45", energy_produced: 0 },
      %{ date: "04/13/2022T23:00", energy_produced: 0 },
      %{ date: "04/13/2022T23:15", energy_produced: 0 },
      %{ date: "04/13/2022T23:30", energy_produced: 0 },
      %{ date: "04/13/2022T23:45", energy_produced: 0 }

    ]

    IO.inspect(raw_data)

    # Enum.map(raw_data, fn x -> 
    #   %{ date: x.date, energy_produced: x.energy_produced } 
    # end)
  end

end
