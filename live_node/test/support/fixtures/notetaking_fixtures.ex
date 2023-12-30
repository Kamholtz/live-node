defmodule LiveNode.NotetakingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveNode.Notetaking` context.
  """

  @doc """
  Generate a template.
  """
  def template_fixture(attrs \\ %{}) do
    {:ok, template} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> LiveNode.Notetaking.create_template()

    template
  end
end
