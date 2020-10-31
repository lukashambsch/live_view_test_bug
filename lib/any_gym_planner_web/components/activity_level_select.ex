defmodule AnyGymPlannerWeb.Components.ActivityLevelSelect do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AnyGymPlanner.Accounts.User

  def render(assigns) do
    ~L"""
      <%= AnyGymPlannerWeb.Form.InputGroup.select_group(@form, :activity_level, activity_level_options()) %>
    """
  end

  def activity_levels() do
    %{
      "Sedentary (No Exercise)" => 0,
      "Light Exercise (1-2 days/week)" => 1,
      "Moderate Exercise (3-5 days/week)" => 2,
      "Heavy Exercise (6-7 days/week)" => 3,
      "Athlete (Twice/day)" => 4
    }
  end

  def get_activity_level_value(gender, form_value) do
    gender
    |> get_activity_levels()
    |> Enum.at(form_value)
  end

  def get_activity_level_form_value(gender, value) do
    gender
    |> get_activity_levels()
    |> Enum.find_index(fn activity_level -> activity_level == value end)
  end

  defp get_activity_levels("male"), do: User.male_activity_levels()
  defp get_activity_levels("female"), do: User.female_activity_levels()

  defp activity_level_options() do
    activity_levels()
    |> Enum.map(fn {k, v} -> [key: k, value: v] end)
    |> Enum.sort(fn one, two -> Keyword.fetch!(one, :value) <= Keyword.fetch!(two, :value) end)
  end
end
