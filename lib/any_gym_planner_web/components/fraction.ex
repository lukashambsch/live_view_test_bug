defmodule AnyGymPlannerWeb.Components.Fraction do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
      <div class="flex items-center">
        <%= if !is_nil(Map.get(assigns, :whole_number)) do %>
          <span class="mr-1"> <%= @whole_number %> </span>
        <% end %>
        <span class="relative -top-1 text-xs"> <%= @numerator %> </span>
        <span class="text-xs">/</span>
        <span class="relative top-1 text-xs"> <%= @denominator %> </span>
      </div>
    """
  end
end
