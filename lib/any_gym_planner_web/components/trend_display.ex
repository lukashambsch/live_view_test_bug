defmodule AnyGymPlannerWeb.Components.TrendDisplay do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlannerWeb.Components.Icon

  def render(assigns) do
    ~L"""
      <div class="flex flex-col items-center relative w-full h-40 p-2 shadow-360 cursor-pointer bg-gray-200 hover:bg-gray-300">
        <div class="text-center"> <%= @label %> </div>
        <%=
          live_component(
            @socket,
            Icon,
            icon_name: get_icon_name(@trend),
            size: :xl7,
            class: get_trend_color(@trend, @target)
          )
        %>
        <div class="text-2xl text-center"> <%= @value %> </div>
        <%=
          live_component(
            @socket,
            Icon,
            icon_name: "add",
            size: :m,
            class: "absolute bg-white text-gray-700 rounded-full h-4 w-4 top-2 right-2"
          )
        %>
    </div>
    """
  end

  defp get_icon_name(:up), do: "arrow-up"
  defp get_icon_name(:down), do: "arrow-down"
  defp get_icon_name(:even), do: "remove"

  defp get_trend_color(trend, target) do
    if trend == target, do: "text-green-500", else: "text-red-500"
  end
end
