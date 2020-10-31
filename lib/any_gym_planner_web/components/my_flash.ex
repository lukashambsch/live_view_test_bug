defmodule AnyGymPlannerWeb.Components.MyFlash do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div
        class="flex flex-col fixed w-full bottom-0 md:w-1/2 lg:w-1/3"
        phx-hook="FlashContainer"
        id="flash-container"
        data-flash="<%= Jason.encode!(@my_flash) %>">
        <%= for flash <- @my_flash do %>
          <div
            class="<%= notify_class(flash.kind) %>"
            phx-hook="FlashNotify"
            id="<%= flash.id %>"
            data-expiration="<%= flash.expiration %>"
            phx-value-id="<%= flash.id %>">
            <%=
              live_component(
                @socket,
                AnyGymPlannerWeb.Components.Icon,
                icon_name: notify_icon_name(flash.kind),
                class: "h-5 w-5 mr-3"
              )
            %>
            <%= flash.message %>
            <%=
              live_component(
                @socket,
                AnyGymPlannerWeb.Components.Icon,
                icon_name: "close",
                class: "h-5 w-5 ml-auto cursor-pointer",
                phx_click: "remove_flash",
                phx_value_id: flash.id
              )
            %>
          </div>
        <% end %>
      </div>
    """
  end

  defp notify_icon_name("default"), do: ""
  defp notify_icon_name("info"), do: "information-circle"
  defp notify_icon_name("success"), do: "checkmark-circle-outline"
  defp notify_icon_name("warning"), do: "warning"
  defp notify_icon_name("error"), do: "alert"

  defp notify_class(level) do
    "flex items-center w-full h-12 text-white py-2 px-4 mt-1 text-sm font-normal #{
      notify_bg_color(level)
    }"
  end

  defp notify_bg_color("default"), do: "bg-gray-700"
  defp notify_bg_color("info"), do: "bg-blue-500"
  defp notify_bg_color("success"), do: "bg-green-500"
  defp notify_bg_color("warning"), do: "bg-orange-500"
  defp notify_bg_color("error"), do: "bg-red-500"
end
