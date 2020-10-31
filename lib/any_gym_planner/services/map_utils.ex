defmodule AnyGymPlanner.MapUtils do
  @spec stringify_keys(map()) :: map()
  def stringify_keys(data) do
    Enum.reduce(data, %{}, fn {key, value}, acc ->
      Map.put(acc, Atom.to_string(key), value)
    end)
  end

  @spec atomize_keys(map()) :: map()
  def atomize_keys(data = %{}) do
    data
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
    |> Enum.into(%{})
  end
end
