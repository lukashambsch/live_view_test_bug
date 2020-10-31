defmodule AnyGymPlannerWeb.Components.IconButton do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="flex items-center text-gray-700 ml-1">
        <button
          title="<%= Map.get(assigns, :title, "") %>"
          class="<%= build_button_class(@disabled, @class) %>"
          phx-click="<%= @phx_click %>"
          <%= if Map.has_key?(assigns, :phx_target) do %>
            phx-target="<%= @phx_target %>"
          <% end %>>
          <div class="flex justify-center items-center h-6 w-6 text-lg">
          <i
            class="flex items-center justify-center icon ion-md-<%= @icon_name %> text-2xl">
          </i>
          </div>
        </button>
        <span class="text-base"> <%= @label %> </span>
      </div>
    """
  end

  defp build_button_class(disabled, custom_class) do
    "flex justify-center items-center cursor-pointer text-gray-700 h-8 w-8 rounded-full hover:bg-gray-300#{
      if disabled, do: " opacity", else: ""
    } #{custom_class}"
  end
end
