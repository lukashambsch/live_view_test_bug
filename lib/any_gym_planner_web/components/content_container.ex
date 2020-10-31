defmodule AnyGymPlannerWeb.Components.ContentContainer do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="overflow-auto flex-grow">
        <div class="content h-full w-screen overflow-y-auto overflow-x-hidden lg:w-1/2 lg:m-auto">
          <%= @inner_content.(assigns) %>
        </div>
        <div class="content-loading hidden h-full w-full justify-center items-center">
          <i class="flex items-center justify-center icon ion-md-refresh spin text-3xl"></i>
        </div>
      </div>
    """
  end
end
