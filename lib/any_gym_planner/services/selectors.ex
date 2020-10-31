defmodule AnyGymPlanner.Selectors do
  @spec get_truthy_num(integer() | float(), integer() | float()) :: integer() | float()
  def get_truthy_num(num, default) when is_nil(num), do: default

  def get_truthy_num(num, default) do
    if num == 0, do: default, else: num
  end
end
