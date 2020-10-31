defmodule AnyGymPlanner.TaskSetup do
  @spec prep_db_task() :: :ok
  def prep_db_task do
    [:postgrex, :ecto]
    |> Enum.each(&Application.ensure_all_started/1)

    AnyGymPlanner.Repo.start_link()

    :ok
  end
end
