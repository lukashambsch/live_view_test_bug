defmodule AnyGymPlanner.Repo do
  use Ecto.Repo,
    otp_app: :any_gym_planner,
    adapter: Ecto.Adapters.Postgres
end
