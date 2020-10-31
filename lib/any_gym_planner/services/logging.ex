defmodule AnyGymPlanner.Logging do
  @sentry Application.get_env(
            :any_gym_planner,
            :sentry,
            AnyGymPlanner.Sentry
          )

  @spec rescue_and_log(function()) :: term() | :error
  def rescue_and_log(func) do
    try do
      func.()
    rescue
      ex ->
        @sentry.capture_exception(ex, stacktrace: __STACKTRACE__)
        :error
    end
  end

  @spec puts(String.t()) :: term()
  def puts(output) do
    # This sucks, but I got sick of seeing it in the test output
    # coveralls-ignore-start
    if Mix.env() != :test do
      IO.puts(output)
    end

    # coveralls-ignore-stop
  end
end
