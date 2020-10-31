defmodule AnyGymPlanner.DateUtils do
  alias AnyGymPlanner.UnitConverter

  # counts Monday as first day of the week
  @spec get_first_day_of_week(Date.t()) :: Date.t()
  def get_first_day_of_week(date) do
    days_back =
      date
      |> Date.day_of_week()
      |> Kernel.*(-1)

    date
    |> Date.add(days_back + 1)
  end

  @spec get_first_day_of_week_of_month(Date.t(), integer()) :: Date.t()
  def get_first_day_of_week_of_month(date, day_of_week) do
    {:ok, first_day} = Date.new(date.year, date.month, 1)
    get_next_day_of_week(first_day, day_of_week)
  end

  @spec get_next_day_of_week(Date.t(), integer()) :: Date.t()
  def get_next_day_of_week(date, day_of_week) do
    case Date.day_of_week(date) == day_of_week do
      true ->
        date

      false ->
        date |> Date.add(1) |> get_next_day_of_week(day_of_week)
    end
  end

  @spec get_last_day_of_week_of_month(Date.t(), integer()) :: Date.t()
  def get_last_day_of_week_of_month(date, day_of_week) do
    {:ok, last_day} = Date.new(date.year, date.month, Date.days_in_month(date))
    get_prev_day_of_week(last_day, day_of_week)
  end

  @spec get_prev_day_of_week(Date.t(), integer()) :: Date.t()
  def get_prev_day_of_week(date, day_of_week) do
    case Date.day_of_week(date) == day_of_week do
      true ->
        date

      false ->
        date |> Date.add(-1) |> get_prev_day_of_week(day_of_week)
    end
  end

  @spec get_first_sunday_of_month(Date.t()) :: Date.t()
  def get_first_sunday_of_month(date) do
    get_first_day_of_week_of_month(date, 7)
  end

  @spec get_next_sunday(Date.t()) :: Date.t()
  def get_next_sunday(date) do
    get_next_day_of_week(date, 7)
  end

  @spec get_next_monday(Date.t()) :: Date.t()
  def get_next_monday(date) do
    get_next_day_of_week(date, 1)
  end

  @spec get_month_sundays(integer(), integer()) :: [Date.t()]
  def get_month_sundays(year, month) do
    {:ok, start_date} = Date.new(year, month, 1)
    {:ok, end_date} = Date.new(year, month, Date.days_in_month(start_date))

    Date.range(start_date, end_date)
    |> Enum.map(fn date ->
      if Date.day_of_week(date) == 7 do
        date
      else
        nil
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  @spec get_last_sunday_of_month(Date.t()) :: Date.t()
  def get_last_sunday_of_month(date) do
    get_last_day_of_week_of_month(date, 7)
  end

  @spec get_prev_sunday(Date.t()) :: Date.t()
  def get_prev_sunday(date) do
    get_prev_day_of_week(date, 7)
  end

  @spec get_next_month(Date.t()) :: Date.t()
  def get_next_month(date \\ Date.utc_today()) do
    case date.month do
      12 -> Date.new(date.year + 1, 1, 1)
      month -> Date.new(date.year, month + 1, 1)
    end
  end

  @spec get_month_name(integer()) :: String.t()
  def get_month_name(month) do
    case month do
      1 -> "January"
      2 -> "February"
      3 -> "March"
      4 -> "April"
      5 -> "May"
      6 -> "June"
      7 -> "July"
      8 -> "August"
      9 -> "September"
      10 -> "October"
      11 -> "November"
      12 -> "December"
    end
  end

  @spec get_age_in_days(Date.t()) :: integer()
  def get_age_in_days(birth_date) do
    Date.diff(Date.utc_today(), birth_date)
  end

  @spec get_age_in_years(Date.t()) :: float()
  def get_age_in_years(birth_date) when is_nil(birth_date), do: 0.0

  @spec get_age_in_years(Date.t()) :: float()
  def get_age_in_years(birth_date) do
    birth_date |> get_age_in_days |> UnitConverter.days_to_years()
  end

  @spec one_hour_ago() :: DateTime.t()
  def one_hour_ago() do
    DateTime.utc_now() |> DateTime.add(-1 * 60 * 60, :second)
  end
end
