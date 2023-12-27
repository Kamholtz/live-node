defmodule LiveNodeWeb.AddLinkLive do
  use Phoenix.LiveView
  

  def mount(_params, _session, socket) do
    temperature = 70 # Let's assume a fixed temperature for now
    {:ok, 
      socket 
      |> assign(:abc, "abc")
    }
  end
end
