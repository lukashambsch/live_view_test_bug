defmodule AnyGymPlanner.GroceryLists.GroceryList do
  use Ecto.Schema

  import Ecto.Changeset

  alias AnyGymPlanner.GroceryLists.{GroceryList, GroceryListItem}

  schema "grocery_lists" do
    field(:week, :date)

    has_many(:grocery_list_items, GroceryListItem, on_replace: :nilify)

    timestamps()
  end

  @spec changeset(%GroceryList{}, map()) :: Ecto.Changeset.t()
  def changeset(%GroceryList{} = grocery_list, attrs) do
    grocery_list
    |> cast(attrs, [:week])
    |> cast_assoc(:grocery_list_items)
    |> validate_required([:week])
  end
end
