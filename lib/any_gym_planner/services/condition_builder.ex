defmodule AnyGymPlanner.ConditionBuilder do
  import Ecto.Query

  @spec build_conditions(map(), map(), :and | :or) :: Ecto.Queryable.t()
  def build_conditions(filters, args, :and), do: build_and_conditions(filters, args)
  def build_conditions(filters, args, :or), do: build_or_conditions(filters, args)

  @spec build_and_conditions(map(), map()) :: Ecto.Queryable.t()
  def build_and_conditions(%{} = filters, %{} = args) do
    args
    |> Enum.reject(fn {_k, v} -> is_nil(v) end)
    |> Enum.reduce(true, fn {k, v}, acc ->
      if Map.has_key?(filters, k) do
        dynamic([n], ^acc and ^filters[k].({k, v}))
      else
        dynamic([n], ^acc)
      end
    end)
  end

  @spec build_or_conditions(map(), map()) :: Ecto.Queryable.t()
  def build_or_conditions(%{} = filters, %{} = args) do
    args
    |> Enum.reject(fn {_k, v} -> is_nil(v) end)
    |> Enum.reduce(false, fn {k, v}, acc ->
      if Map.has_key?(filters, k) do
        dynamic([i], ^acc or ^filters[k].({k, v}))
      else
        dynamic([i], ^acc)
      end
    end)
  end

  @spec get_matching_condition({String.t(), term()}) :: Ecto.Queryable.t()
  def get_matching_condition({field_name, value}) do
    dynamic([i], field(i, ^field_name) == ^value)
  end

  @spec get_ilike_condition({String.t(), term()}) :: Ecto.Queryable.t()
  def get_ilike_condition({field_name, value}) do
    dynamic([i], ilike(field(i, ^field_name), ^"%#{value}%"))
  end

  @spec get_in_list_condition({String.t(), term()}) :: Ecto.Queryable.t()
  def get_in_list_condition({field_name, value}) do
    dynamic([i], field(i, ^field_name) in ^value)
  end

  @spec build_exact_match_conditions([atom()]) :: map()
  def build_exact_match_conditions(keys) do
    Enum.reduce(keys, %{}, fn key, acc ->
      Map.put(acc, key, &get_matching_condition/1)
    end)
  end

  @spec build_partial_match_conditions([atom()]) :: map()
  def build_partial_match_conditions(keys) do
    Enum.reduce(keys, %{}, fn key, acc ->
      Map.put(acc, key, &get_ilike_condition/1)
    end)
  end
end
