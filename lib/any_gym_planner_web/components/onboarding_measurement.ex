defmodule AnyGymPlannerWeb.Components.OnboardingMeasurement do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlannerWeb.Components.{ContentContainer, OnboardingStepButtons}
  alias AnyGymPlannerWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
      <%= live_component(@socket, ContentContainer) do %>
        <div class="w-full md:w-1/2 md:m-auto">
          <div class="flex items-center text-xl p-6 bg-green-500 text-white font-medium sm:text-2xl md:text-3xl">
            Add your measurements to get more accurate tracking.
          </div>

          <div class="flex w-full justify-center">
            <img
              src="<%= Routes.static_path(@socket, @image_path) %>"
              alt="<%= @image_alt %>"
              class="w-64 h-72">
          </div>

            <%= f = form_for(@changeset, "#", [phx_submit: :onboarding_next, phx_change: :validate, id: @form_name, class: "flex flex-col p-4 items-center justify-center"]) %>
              <%= AnyGymPlannerWeb.Form.InputGroup.text_input_group(f, @input_field) %>
            </form>
        </div>
        <%= live_component(@socket, OnboardingStepButtons, can_skip: true, form_name: @form_name) %>
      <% end %>
    """
  end
end
