defmodule AnyGymPlannerWeb.Components.MealSummary do
  use Phoenix.LiveComponent

  alias AnyGymPlannerWeb.Components.{FinishMealButton, MealRatingButton}

  def render(assigns) do
    ~L"""
    <div phx-click="go_to_meal" phx-value-id="<%= @meal.id %>" class="h-1/3 relative p-2 border-solid border-gray-400 border-0 <%= if @index > 0, do: "border-t", else: "" %>">
        <div class="text-xl mb-1 w-3/4">
          <%= @meal.recipe_group.name %>
        </div>
        <div class="text-sm">
          <%= "#{@meal.total_calories} calories" %>
        </div>
        <div class="text-sm">
          <%= if is_nil(@meal.recipe_group.estimated_time) do %>
            No estimated time
          <% else %>
            <%= "#{@meal.recipe_group.estimated_time} mins" %>
          <% end %>
        </div>
        <div class="absolute top-1 right-0 mr-1 mt-1 flex items-center">
          <%=
            live_component(
              @socket,
              MealRatingButton,
              id: @meal.id,
              recipe_group_id: @meal.recipe_group_id,
              user_id: @current_user.id
            )
          %>
          <%= live_component(@socket, FinishMealButton, id: @meal.id, meal: @meal, user_id: @current_user.id) %>
        </div>
      </div>
    """
  end
end
