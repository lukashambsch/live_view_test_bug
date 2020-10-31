defmodule AnyGymPlannerWeb.Components.ErrorContent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
      <div class="flex flex-col items-center justify-center h-full">
        <div class="text-black text-6xl font-bold mb-6"><%= @header %></div>
        <div class="w-3/4 text-gray-800 text-sm text-center leading-tight">
          <%= @message %>
        </div>
      </div>
    """
  end
end
