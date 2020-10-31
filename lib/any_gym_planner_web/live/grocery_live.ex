defmodule AnyGymPlannerWeb.GroceryLive do
  use AnyGymPlannerWeb, :live_view

  alias AnyGymPlanner.{Fraction, GroceryLists, StringUtils}

  alias AnyGymPlannerWeb.Components.{
    Button,
    ContentContainer,
    GroceryListDatePicker,
    Icon
  }

  alias AnyGymPlannerWeb.GroceryLive.{GroceryListDatePicker, MissingGroceryList}

  def render(assigns) do
    ~L"""
      <%=
        live_component(
          @socket,
          GroceryListDatePicker,
          id: "grocery-list-date-picker",
          selected_date: @selected_date
        )
      %>

      <%= live_component(@socket, ContentContainer) do %>
        <%= if @grocery_list do %>
          <div class="flex align-center justify-center text-2xl mt-3">
            Week of <%= "#{@selected_date.month}/#{@selected_date.day}" %>
          </div>
          <%=
            live_component(
              @socket,
              Button,
              bg: "green",
              text: "white",
              class: "w-full mx-2 text-base rounded-full shadow-360"
            ) do %>
              Order Online
            <% end %>
          </div>
          <%= for grocery_list_item <- @grocery_list.grocery_list_items do %>
            <div class="<%= get_row_class(grocery_list_item.is_purchased) %>" phx-click="toggle_is_purchased" phx-value-item="<%= grocery_list_item.id %>">
              <div class="mr-2">
                <%= StringUtils.title_case(grocery_list_item.food.name) %>
              </div>
              <div class="text-gray-600 font-light">
                <%= "#{Fraction.to_rounded_fraction(grocery_list_item.amount, 4)} #{grocery_list_item.unit_name}" %>
              </div>
              <%=
                live_component(
                  @socket,
                  Icon,
                  icon_name: "checkmark-circle-outline",
                  title: "Mark #{grocery_list_item.food.name} off your grocery list",
                  class: get_icon_class(grocery_list_item.is_purchased)
                )
              %>
            </div>
          <% end %>
        <% else %>
          <%= live_component(@socket, MissingGroceryList, selected_date: @selected_date) %>
        <% end %>
      <% end %>
    """
  end

  def mount(%{"week" => week}, _session, socket) do
    {:ok, selected_date} = Date.from_iso8601(week)

    assigned =
      socket
      |> assign(selected_date: selected_date)
      |> assign(grocery_list: nil)

    {:ok, assigned}
  end

  def handle_event("toggle_is_purchased", %{"item" => grocery_list_item_id}, socket) do
    grocery_list_item = GroceryLists.get_grocery_list_item!(grocery_list_item_id)

    {:ok, _updated} =
      GroceryLists.update_grocery_list_item(grocery_list_item, %{
        is_purchased: !grocery_list_item.is_purchased
      })

    {:noreply,
     socket
     |> assign(
       grocery_list:
         GroceryLists.get_grocery_list(
           nil,
           socket.assigns.selected_date
         )
     )}
  end

  defp get_row_class(is_purchased) do
    is_purchased_class =
      if is_purchased do
        "shadow-none border border-solid border-gray-200"
      else
        ""
      end

    "flex items-center h-12 px-4 cursor-pointer my-3 mx-2 rounded-full shadow-360 #{
      is_purchased_class
    }"
    |> String.trim()
  end

  defp get_icon_class(is_purchased) do
    "ml-auto #{if is_purchased, do: "text-green-500", else: "text-gray-300"}"
  end

  defp get_missing_food_names(grocery_list_items) do
    grocery_list_items
    |> Enum.filter(fn item -> item.is_purchased == false end)
    |> Enum.map(fn item -> item.food.name end)
  end
end
