defmodule LiveNodeWeb.PromoLive do
  # 6
  use LiveNodeWeb, :live_view
  alias LiveNode.Promo
  alias LiveNode.Promo.Recipient

  # 7
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign_recipient()
      |> assign_changeset()}
  end
  def assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end
  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket
    |> assign(:changeset, Promo.change_recipient(recipient))
  end

  # 8
  def handle_event(
    "validate",
    %{"recipient" => recipient_params},
    %{assigns: %{recipient: recipient}} = socket) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)
    {:noreply,
      socket
      |> assign(:changeset, changeset)}
  end


end
