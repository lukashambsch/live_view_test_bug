defmodule AnyGymPlanner.Guards do
  @spec is_empty(String.t() | nil) :: boolean()
  defguard is_empty(value) when is_nil(value) or value == ""

  @spec is_nil_or_zero(integer() | nil) :: boolean()
  defguard is_nil_or_zero(value) when is_nil(value) or value == 0
end
