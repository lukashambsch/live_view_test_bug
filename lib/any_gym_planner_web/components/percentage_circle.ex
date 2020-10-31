defmodule AnyGymPlannerWeb.Components.PercentageCircle do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlannerWeb.Components.Icon

  def render(assigns) do
    ~L"""
      <div class="flex flex-col items-center relative w-full h-40 p-2 shadow-360 cursor-pointer bg-gray-200 hover:bg-gray-300">
        <span> <%= @label %> </span>
        <div class="flex h-40 w-40">
          <div class="w-full justify-around">
            <svg viewBox="0 0 36 36" class="block mt-1 mx-auto w-9/12">
              <path
                class="stroke-current text-white"
                fill="transparent"
                stroke-width="3"
                d="M18 2.0845
                  a 15.9155 15.9155 0 0 1 0 31.831
                  a 15.9155 15.9155 0 0 1 0 -31.831"
              />
              <path
                class="<%= get_fill_color(@percentage) %> stroke-current circle"
                fill="transparent"
                stroke-width="2"
                stroke-dasharray="<%= "#{@percentage}, 100" %>"
                d="M18 2.0845
                  a 15.9155 15.9155 0 0 1 0 31.831
                  a 15.9155 15.9155 0 0 1 0 -31.831"
              />
              <text
                x="18"
                y="20.35"
                class="fill-current text-gray-700 text-xxxs percentage">
                <%= "#{@percentage}%" %>
              </text>
            </svg>
          </div>
        </div>
        <%=
          live_component(
            @socket,
            Icon,
            icon_name: "arrow-forward",
            size: :m,
            class: "absolute bg-white text-gray-800 rounded-full h-4 w-4 top-2 right-2"
          )
        %>
      </div>
    """
  end

  defp get_fill_color(percentage) do
    if percentage < 80, do: "text-red-500", else: "text-green-500"
  end
end
