defmodule AnyGymPlanner.EnumUtils do
  @spec first_with_value([map()], String.t()) :: term()
  def first_with_value(items, field) do
    Enum.find(
      items,
      fn item -> !is_nil(Map.fetch!(item, field)) end
    )
  end

  @spec last_with_value([map()], String.t()) :: term()
  def last_with_value(items, field) do
    items |> Enum.reverse() |> first_with_value(field)
  end
end
