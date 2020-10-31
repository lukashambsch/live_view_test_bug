defmodule AnyGymPlannerWeb.Components.ErrorScreen do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="flex flex-col items-center justify-center h-full">
        <div class="text-black text-6xl font-bold mb-6"><%= @header %></div>
        <div class="w-3/4 text-gray-800 text-sm text-center leading-tight">
          <%= @inner_content.(assigns) %>
        </div>
      </div>
    """
  end
end
