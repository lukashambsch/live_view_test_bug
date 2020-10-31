defmodule AnyGymPlannerWeb.Components.OnboardingStepButtons do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlannerWeb.Components.Button

  def render(assigns) do
    ~L"""
      <div class="absolute flex bottom-0 justify-between w-full h-12 border-0 border-t border-solid border-gray-300 md:w-1/2 md:m-auto">
        <%= if @can_skip do %>
          <%=
            live_component(
              @socket,
              Button,
              bg: "white",
              text: "black",
              class: "text-base text-gray-600 w-1/2 border-0 border-r border-solid border-gray-400",
              phx_click: "onboarding_skip"
            ) do %>
            Skip
          <% end %>
        <% end %>

        <%=
          live_component(
            @socket,
            Button,
            bg: "white",
            text: "black",
            class: build_next_class(@can_skip),
            type: "submit",
            form: @form_name
          ) do %>
          Next
        <% end %>
      </div>
    """
  end

  defp build_next_class(can_skip) do
    width = if can_skip, do: "w-1/2", else: "w-full"
    "text-base ml-auto #{width}"
  end
end
