defmodule AnyGymPlannerWeb.Components.TileDisplay do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlannerWeb.Components.Icon

  def render(assigns) do
    ~L"""
      <div class="flex flex-col items-center relative w-full h-40 p-2 shadow-360 cursor-pointer bg-gray-200 hover:bg-gray-300">
        <div class="text-center"> <%= @label %> </div>
        <div class="text-6xl my-auto <%= Map.get(assigns, :color, "text-gray-700") %>"> <%= @value %> </div>
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
end
