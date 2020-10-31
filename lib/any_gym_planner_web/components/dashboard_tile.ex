defmodule AnyGymPlannerWeb.Components.DashboardTile do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="md:w-1/2 px-4 py-2">
        <%= @inner_content.(assigns) %>
      </div>
    """
  end
end
