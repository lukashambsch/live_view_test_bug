defmodule AnyGymPlanner.UnitConverter do
  @spec lbs_to_kg(number()) :: float()
  def lbs_to_kg(lbs) do
    lbs * 0.45359237
  end

  @spec inches_to_cm(number()) :: float()
  def inches_to_cm(inches) do
    inches * 2.54
  end

  @spec days_to_years(number()) :: float()
  def days_to_years(days) do
    days / 365
  end

  @spec years_to_days(number()) :: integer()
  def years_to_days(years) do
    round(years * 365)
  end
end
