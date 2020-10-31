defmodule AnyGymPlanner.GroceryLists.GroceryListItem do
  use Ecto.Schema

  import Ecto.Changeset

  alias AnyGymPlanner.GroceryLists.{GroceryListItem, GroceryList}

  # alias AnyGymPlanner.Recipes.Food

  schema "grocery_list_items" do
    field(:amount, :float)
    field(:is_purchased, :boolean, default: false)
    field(:unit_name, :string)

    # belongs_to(:food, Food)
    belongs_to(:grocery_list, GroceryList)

    timestamps()
  end

  @spec changeset(%GroceryListItem{}, map()) :: Ecto.Changegset.t()
  def changeset(%GroceryListItem{} = grocery_list_item, attrs) do
    grocery_list_item
    |> cast(attrs, [:amount, :is_purchased, :unit_name, :grocery_list_id])
    |> validate_required([:amount])
  end
end
