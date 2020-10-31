defmodule AnyGymPlannerWeb.Components.MealRatingButton do
  use Phoenix.LiveComponent

  alias AnyGymPlanner.{Profiles, Repo}
  alias AnyGymPlannerWeb.Components.Icon

  def render(assigns) do
    ~L"""
      <span
        title="<%= "Like Recipe Group #{@recipe_group_id}" %>"
        class="cursor-pointer"
        phx-click="toggle_meal_like"
        phx-target="<%= @myself %>">
        <%=
          live_component(
            @socket,
            Icon,
            icon_name: "thumbs-up",
            class: "mr-2 #{get_like_color(@rating)}"
          )
        %>
      </span>
      <span
        title="<%= "Dislike Recipe Group #{@recipe_group_id}" %>"
        class="cursor-pointer"
        phx-click="toggle_meal_dislike"
        phx-target="<%= @myself %>">
        <%=
          live_component(
            @socket,
            Icon,
            icon_name: "thumbs-down",
            class: "mr-2 #{get_dislike_color(@rating)}"
          )
        %>
      </span>
    """
  end

  def update(%{user_id: user_id, recipe_group_id: recipe_group_id}, socket) do
    rating = Profiles.get_rating(user_id, recipe_group_id)
    {:ok, assign(socket, rating: rating, user_id: user_id, recipe_group_id: recipe_group_id)}
  end

  def handle_event("toggle_meal_like", _, socket) do
    toggle_meal_rating(socket, :like)
  end

  def handle_event("toggle_meal_dislike", _, socket) do
    toggle_meal_rating(socket, :dislike)
  end

  defp toggle_meal_rating(socket, type) do
    user_id = socket.assigns.user_id
    next_rating = get_next_rating(socket.assigns.rating, type)

    rating =
      Profiles.Rating
      |> Repo.create_or_update!(
        %{rating: next_rating, user_id: user_id, recipe_group_id: socket.assigns.recipe_group_id},
        user_id: user_id,
        recipe_group_id: socket.assigns.recipe_group_id
      )

    {:noreply, assign(socket, rating: rating)}
  end

  defp get_next_rating(%{rating: 1}, :like), do: 0
  defp get_next_rating(_current_rating, :like), do: 1

  defp get_next_rating(%{rating: -1}, :dislike), do: 0
  defp get_next_rating(_current_rating, :dislike), do: -1

  defp get_like_color(%{rating: 1}), do: "text-green-500"
  defp get_like_color(_), do: "text-gray-400"

  defp get_dislike_color(%{rating: -1}), do: "text-red-500"
  defp get_dislike_color(_), do: "text-gray-400"
end
