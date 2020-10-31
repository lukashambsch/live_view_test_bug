defmodule AnyGymPlanner.GroceryLists.Tasks do
  @moduledoc """
  Cronjob tasks. Scheduled in config/prod.exs.
  """

  alias AnyGymPlanner.{Accounts, DateUtils, GroceryLists, Logging}

  @spec send_weekly_grocery_list() :: none()
  def send_weekly_grocery_list() do
    date = DateUtils.get_next_sunday(Date.utc_today())

    Accounts.list_weekly_grocery_list_email_users()
    |> Enum.each(fn user ->
      Logging.rescue_and_log(fn -> GroceryLists.Messaging.weekly_list(user.id, date) end)
    end)
  end
end
