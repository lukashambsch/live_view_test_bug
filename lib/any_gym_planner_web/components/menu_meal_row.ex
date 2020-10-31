defmodule AnyGymPlannerWeb.Components.MenuMealRow do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlannerWeb.Components.Icon

  def render(assigns) do
    ~L"""
      <div class="flex flex-no-wrap relative overflow-hidden h-12">
        <div
          class="flex min-w-full absolute justify-start items-center pr-2 relative h-12 left-0 h-12 menu-meal-row-transition"
          phx-click="toggle_meal_expansion"
          phx-value-id="<%= @meal.id %>"
          phx-hook="MenuMealRow">
            <%= live_component(
              @socket,
              Icon,
              icon_name: get_arrow_icon_name(@meal.id, @expanded_meals),
              title: "Show ingredients for #{@meal.recipe_group.name}",
              class: "w-8"
            ) %>
            <div class="text-lg font-light">
              <%= @meal.recipe_group.name %>
            </div>
            <%= live_component(
              @socket,
              Icon,
              icon_name: "swap",
              title: "Swap out #{@meal.recipe_group.name}",
              size: :l,
              class: "h-4 w-4 ml-auto",
              phx_click: "change_meal",
              phx_value_id: @meal.id
            ) %>
        </div>
        <div class="flex min-w-full absolute items-center justify-center left-1/1 h-12 menu-meal-row-transition">
          <%= live_component(
            @socket,
            Icon,
            icon_name: "refresh",
            title: "Finding new meal",
            size: :xl,
            class: "text-gray-700 spin"
          ) %>
        </div>
      </div>
      <%= if is_expanded?(@meal.id, @expanded_meals) do %>
        <div class="text-base font-light">
          <%= for name <- get_ingredient_names(@meal.recipe_group) do %>
            <div class="ml-5 mt-2"><%= name %></div>
          <% end %>
        </div>
      <% end %>
    """
  end

  defp get_ingredient_names(recipe_group) do
    recipe_group.recipes
    |> Enum.map(fn recipe ->
      Enum.map(recipe.ingredients, fn ingredient -> ingredient.food.name end)
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sort()
  end

  defp get_arrow_icon_name(meal_id, expanded_meals) do
    if is_expanded?(meal_id, expanded_meals) do
      "arrow-dropdown"
    else
      "arrow-dropright"
    end
  end

  defp is_expanded?(meal_id, expanded_meals) do
    Integer.to_string(meal_id) in expanded_meals
  end
end
