defmodule AnyGymPlannerWeb.Components.MealPlanDatePicker do
  use Phoenix.LiveComponent

  alias AnyGymPlannerWeb.Components.Icon

  def render(assigns) do
    ~L"""
      <div
        class="w-full border-0 border-b border-gray-400 border-solid z-10 bg-white h-12 flex justify-between items-center text-gray-800">
        <%= live_component(@socket, Icon, title: "View Previous Meal Plan", icon_name: "arrow-back", class: "ml-3", phx_click: "prev_meal_plan") %>
        <div class="flex items-center justify-center">
          <%= live_component(@socket, Icon, icon_name: "calendar", class: "h-5 w-5 mr-1") %>
          <%= Timex.format!(@selected_date, "%a, %b %-d", :strftime) %>
        </div>
        <%= live_component(@socket, Icon, title: "View Next Meal Plan", icon_name: "arrow-forward", class: "mr-3", phx_click: "next_meal_plan") %>
      </div>
    """
  end
end
