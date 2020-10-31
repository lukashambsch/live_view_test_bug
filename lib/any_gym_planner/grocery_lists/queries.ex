defmodule AnyGymPlanner.GroceryLists.Queries do
  @moduledoc """
  Reusable queries for the GroceryLists context.
  """

  import Ecto.Query

  alias AnyGymPlanner.GroceryLists.{GroceryList, GroceryListItem}

  @spec user_grocery_lists(integer()) :: Ecto.Queryable.t()
  def user_grocery_lists(user_id), do: GroceryList |> where([g], g.user_id == ^user_id)

  @spec grocery_list_grocery_list_items(integer()) :: Ecto.Queryable.t()
  def grocery_list_grocery_list_items(grocery_list_id) do
    GroceryListItem
    |> where([i], i.grocery_list_id == ^grocery_list_id)
  end
end
