defmodule LiveNodeWeb.VegaLiteExamples do
  use Phoenix.LiveView
  alias VegaLite, as: Vl
  
  def mount(_params, _session, socket) do
    {:ok, 
      socket 
    }
  end

  # First attempt - tried to render html
  def vega_lite_function_component(assigns) do
    _data = [
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

    assigns = assign(assigns, :plot, plot)

    ~H"""
    <div>
      <%= @plot %>
    </div>
    """
  end
end
