defmodule AnyGymPlannerWeb.Components.Icon do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <i
        class="<%= build_class(@icon_name, Map.get(assigns, :size, :xl2), Map.get(assigns, :class, "")) %>"
        title="<%= Map.get(assigns, :title, "") %>"
        <%= if Map.has_key?(assigns, :phx_click) do %>
          phx-click="<%= @phx_click %>"
        <% end %>
        <%= if Map.has_key?(assigns, :phx_value_id) do %>
          phx-value-id="<%= @phx_value_id %>"
        <% end %>
        <%= if Map.has_key?(assigns, :phx_hook) do %>
          phx-hook="<%= @phx_hook %>"
        <% end %>
      >
      </i>
    """
  end

  defp build_class(icon_name, size, custom_class) do
    "flex items-center justify-center icon ion-md-#{icon_name} #{get_size_class(size)} #{
      custom_class
    }"
  end

  defp get_size_class(:xs), do: "text-xs"
  defp get_size_class(:s), do: "text-sm"
  defp get_size_class(:m), do: "text-base"
  defp get_size_class(:l), do: "text-lg"
  defp get_size_class(:xl), do: "text-xl"
  defp get_size_class(:xl2), do: "text-2xl"
  defp get_size_class(:xl3), do: "text-3xl"
  defp get_size_class(:xl7), do: "text-7xl"
  defp get_size_class(_size), do: "text-2xl"
end
