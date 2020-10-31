defmodule AnyGymPlannerWeb.Components.Button do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <button
        class="<%= build_class(Map.get(assigns, :bg, "green"), Map.get(assigns, :text, "white"), Map.get(assigns, :class, "")) %>"
        type="<%= Map.get(assigns, :type, "button") %>"
        <%= if Map.get(assigns, :form) do %>
          form="<%= @form %>"
        <% end %>
        <%= if Map.get(assigns, :phx_click) do %>
          phx-click="<%= @phx_click %>"
        <% end %>
        <%= if Map.get(assigns, :phx_target) do %>
          phx-target="<%= @phx_target %>"
        <% end %>
      >
        <%= @inner_content.(assigns) %>
      </button>
    """
  end

  defp build_class(bg, text, custom_class) do
    [
      "disabled:opacity-50 tracking-wide py-2 px-4 rounded focus:outline-none focus:shadow-outline shadow-360",
      custom_class
    ]
    |> Enum.filter(fn class -> class !== "" && !is_nil(class) end)
    |> Enum.join(" ")
    |> add_bg_classes(bg)
    |> add_text_classes(text)
  end

  defp add_bg_classes(class, bg_color) do
    "#{class} bg-#{bg_color}-500 hover:bg-#{bg_color}-600"
  end

  defp add_text_classes(class, text_color) do
    "#{class} text-#{text_color}"
  end
end
