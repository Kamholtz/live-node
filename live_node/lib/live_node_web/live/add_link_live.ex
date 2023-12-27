defmodule LiveNodeWeb.AddLinkLive do
  use Phoenix.LiveView
  alias LiveNode.Promo.Link

  attr :field, Phoenix.HTML.FormField
  attr :rest, :global, include: ~w(type)
  def input(assigns) do
    ~H"""
    <input id={@field.id} name={@field.name} value={@field.value} {@rest} />
    """
  end

  # def handle_event(
  #   "validate",
  #   %{"recipient" => recipient_params},
  #   %{assigns: %{recipient: recipient}} = socket) do
  #   changeset =
  #     recipient
  #     |> Promo.change_recipient(recipient_params)
  #     |> Map.put(:action, :validate)
  #   {:noreply,
  #     socket
  #     |> assign(:changeset, changeset)}
  # end

  def mount(_params, _session, socket) do
    {:ok, 
      socket 
      |> assign(:abc, "abc")
      |> assign(:form, to_form(Link.changeset(%Link{}, %{url: "https://abc.com", text: "aabbcc"})))
    }
  end
end
