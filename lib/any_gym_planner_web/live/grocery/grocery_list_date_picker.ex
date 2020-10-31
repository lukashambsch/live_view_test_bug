defmodule AnyGymPlannerWeb.GroceryLive.GroceryListDatePicker do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlanner.DateUtils
  alias AnyGymPlannerWeb.Components.TopBar
  alias AnyGymPlannerWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
      <%= live_component(@socket, TopBar, class: "") do %>
        <div class="flex justify-between items-stretch h-12 text-gray-500 w-full">
          <%= for date <- @dates do %>
            <div
              class="<%= build_class(date, @selected_date) %>"
              phx-click="select_date"
              phx-target="<%= @myself %>"
              phx-value-date="<%= date %>"
            >
              <%= "#{date.month}/#{date.day}" %>
            </div>
          <% end %>
        </div>
      <% end %>
    """
  end

  def update(%{selected_date: selected_date}, socket) do
    {
      :ok,
      socket
      |> assign(selected_date: selected_date)
      |> assign(dates: DateUtils.get_month_sundays(selected_date.year, selected_date.month))
    }
  end

  def handle_event("select_date", %{"date" => date}, socket) do
    {
      :noreply,
      push_redirect(
        socket,
        to: Routes.live_path(socket, AnyGymPlannerWeb.GroceryLive, date)
      )
    }
  end

  defp build_class(date, selected_date) do
    selected_class =
      if Date.diff(selected_date, date) == 0 do
        "text-black border-solid border-b-2 border-green-500 border-0"
      else
        ""
      end

    String.trim("flex items-center justify-center flex-grow text-base #{selected_class}")
  end
end
