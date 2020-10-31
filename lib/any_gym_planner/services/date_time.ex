defmodule AnyGymPlanner.DateTime do
  @moduledoc """
  Wrapper module for DateTime to allow mocking.
  """

  @callback utc_now() :: DateTime.t()

  defdelegate utc_now(), to: DateTime
end
