defmodule AnyGymPlanner.QueryBuilder do
  import Ecto.Query

  alias AnyGymPlanner.ConditionBuilder

  @spec order(Ecto.Queryable.to(), String.t(), String.t()) :: Ecto.Queryable.t()
  def order(queryable, order_field, order_dir) do
    order_field = String.to_existing_atom(order_field)

    case order_dir do
      "desc" -> queryable |> order_by([i], desc: ^order_field)
      _ -> queryable |> order_by([u], asc: ^order_field)
    end
  end

  @spec filter(Ecto.Queryable.t(), map(), map(), :and | :or) :: Ecto.Queryable.t()
  def filter(queryable, %{} = filters, args, filter_type) do
    conditions = ConditionBuilder.build_conditions(filters, args, filter_type)

    queryable |> where(^conditions)
  end

  @spec count(Ecto.Query.t()) :: Ecto.Query.t()
  def count(queryable), do: queryable |> select([o], count("*"))

  @spec latest_id(module()) :: Ecto.Queryable.t()
  def latest_id(schema) do
    schema
    |> select([o], o.id)
    |> order_by([o], desc: o.id)
    |> limit(1)
  end
end
