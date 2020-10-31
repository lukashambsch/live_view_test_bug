defmodule AnyGymPlannerWeb.GroceryLive.MissingGroceryList do
  use Phoenix.LiveComponent

  alias AnyGymPlannerWeb.Components.ErrorScreen

  def render(assigns) do
    ~L"""
      <%= live_component(@socket, ErrorScreen, header: "Sorry!") do %>
        <span>
          We haven't created your grocery list for <strong><%= Date.to_iso8601(@selected_date) %></strong> yet.
        </span>
      <% end %>
    """
  end
end
