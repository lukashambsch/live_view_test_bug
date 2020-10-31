defmodule AnyGymPlannerWeb.Components.MealRecipeIngredient do
  use Phoenix.LiveComponent

  alias AnyGymPlanner.Fraction
  alias AnyGymPlannerWeb.Components

  def render(assigns) do
    ~L"""
      <div class="w-full md:w-1/2 lg:w-1/4">
        <span class="inline-block mr-1">
          <div class="w-10">
            <%= if @amount_fraction == "pinch" do %>
              <%= "1" %>
            <% else %>
              <%= if Fraction.is_fraction?(@amount_fraction) do %>
                <%=
                  live_component(
                    @socket,
                    Components.Fraction,
                    whole_number: Fraction.extract_integer(@amount_fraction),
                    numerator: Fraction.extract_numerator(@amount_fraction),
                    denominator: Fraction.extract_denominator(@amount_fraction)
                  )
                %>
              <% else %>
                <%= @amount_fraction %>
              <% end %>
            <% end %>
          </div>
        </span>
        <%= case unit_name_display(@ingredient.unit.name, @ingredient.food.whole_unit, @amount_fraction) do %>
          <% "" -> %> <span></span>

          <% unit_name -> %>
            <span class="inline-block mr-1">
              <%= unit_name %>
            </span>
        <% end %>
        <span class="font-medium">
          <%= @ingredient.food.name %>
        </span>
      </div>
    """
  end

  def update(%{meal: meal, recipe_group_recipe: rgr, ingredient: ingredient}, socket) do
    amount =
      ingredient_amount(
        ingredient.amount,
        rgr.recipe_servings,
        meal.recipe_group.servings,
        rgr.recipe.servings,
        meal.servings
      )

    amount_fraction = ingredient_amount_fraction(amount, ingredient.unit.name)

    {:ok,
     socket
     |> assign(amount: amount)
     |> assign(amount_fraction: amount_fraction)
     |> assign(ingredient: ingredient)}
  end

  defp ingredient_amount(amount, rgr_servings, group_servings, recipe_servings, meal_servings) do
    servings_of_recipe_in_group = rgr_servings / group_servings
    amount / recipe_servings * meal_servings * servings_of_recipe_in_group
  end

  defp ingredient_amount_fraction(ingredient_amount, unit_name) do
    max_denominator = if unit_name == "whole", do: 4, else: 8

    case Fraction.to_rounded_fraction(ingredient_amount, max_denominator) do
      "0" -> "pinch"
      rounded_fraction -> rounded_fraction
    end
  end

  defp unit_name_display(_unit_name, _food_whole_unit, "pinch"), do: "pinch"
  defp unit_name_display("whole", nil, _amount), do: ""
  defp unit_name_display("whole", food_whole_unit, _amount), do: food_whole_unit
  defp unit_name_display(unit_name, _food_whole_unit, _amount), do: unit_name
end
