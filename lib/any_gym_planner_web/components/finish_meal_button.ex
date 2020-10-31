defmodule AnyGymPlannerWeb.Components.FinishMealButton do
  use Phoenix.LiveComponent

  alias AnyGymPlannerWeb.Components.Icon
  alias AnyGymPlanner.MealPlans

  def render(assigns) do
    ~L"""
    <span title="<%= "Mark Meal #{@meal.id} as Finished" %>" phx-click="finish_meal" phx-target="<%= @myself %>">
        <%=
          live_component(
            @socket,
            Icon,
            icon_name: "checkmark",
            class: "border border-solid mr-2 h-7 w-7 rounded-full #{get_color(@meal.is_finished)}"
          )
        %>
      </span>
    """
  end

  def update(%{meal: meal}, socket) do
    {:ok, assign(socket, meal: meal)}
  end

  def handle_event("finish_meal", _, socket) do
    {:ok, updated} =
      socket.assigns.meal
      |> MealPlans.update_meal(%{is_finished: !socket.assigns.meal.is_finished})

    {:noreply, socket |> assign(meal: updated)}
  end

  defp get_color(true), do: "text-green-400 border-green-400"
  defp get_color(false), do: "text-gray-400 border-gray-400"
end
