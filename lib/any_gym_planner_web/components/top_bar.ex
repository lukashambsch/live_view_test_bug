defmodule AnyGymPlannerWeb.Components.TopBar do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="h-12">
        <div class="<%= build_class(@class) %>">
          <%= @inner_content.(assigns) %>
        </div>
      </div>
    """
  end

  defp build_class(custom_class) do
    "flex items-center w-full border-0 border-b border-gray-400 border-solid z-10 bg-white h-12 #{
      custom_class
    }"
  end
end
