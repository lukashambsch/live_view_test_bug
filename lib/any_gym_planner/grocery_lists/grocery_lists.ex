defmodule AnyGymPlanner.GroceryLists do
  import Ecto.Query

  alias AnyGymPlanner.GroceryLists.{GroceryList, GroceryListItem, Queries}
  alias AnyGymPlanner.Repo

  @spec list_grocery_lists() :: [%GroceryList{}]
  def list_grocery_lists do
    Repo.all(GroceryList)
  end

  @spec list_grocery_lists(integer()) :: [%GroceryList{}]
  def list_grocery_lists(user_id) do
    Queries.user_grocery_lists(user_id) |> Repo.all()
  end

  @spec get_grocery_list!(integer()) :: %GroceryList{}
  def get_grocery_list!(id), do: Repo.get!(GroceryList, id)

  @spec get_grocery_list(integer(), String.t()) :: %GroceryList{} | nil
  def get_grocery_list(user_id, week) do
    grocery_list_item_query =
      GroceryListItem
      |> join(:inner, [gli], f in assoc(gli, :food))
      |> order_by([gli, f], f.name)
      |> preload(:food)

    GroceryList
    |> preload(grocery_list_items: ^grocery_list_item_query)
    |> Repo.get_by(week: week)
  end

  @spec create_grocery_list(map()) :: {:ok, %GroceryList{}} | {:error, Ecto.Changeset.t()}
  def create_grocery_list(attrs \\ %{}) do
    %GroceryList{}
    |> GroceryList.changeset(attrs)
    |> Repo.insert()
  end

  @spec get_or_create_grocery_list!(integer(), integer(), map()) :: %GroceryList{}
  def get_or_create_grocery_list!(user_id, week, attrs \\ %{}) do
    GroceryList
    |> Repo.get_or_create!(
      attrs,
      user_id: user_id,
      week: week
    )
  end

  @spec update_grocery_list(%GroceryList{}, map()) ::
          {:ok, %GroceryList{}} | {:error, Ecto.Changeset.t()}
  def update_grocery_list(%GroceryList{} = grocery_list, attrs) do
    grocery_list
    |> GroceryList.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_grocery_list(%GroceryList{}) ::
          {:ok, %GroceryList{}} | {:error, Ecto.Changeset.t()}
  def delete_grocery_list(%GroceryList{} = grocery_list) do
    Repo.delete(grocery_list)
  end

  @spec list_grocery_list_items() :: [%GroceryListItem{}]
  def list_grocery_list_items do
    Repo.all(GroceryListItem)
  end

  @spec list_grocery_list_items(%GroceryList{}) :: [%GroceryListItem{}]
  def list_grocery_list_items(grocery_list) do
    Queries.grocery_list_grocery_list_items(grocery_list.id)
    |> Repo.all()
  end

  @spec get_grocery_list_item!(integer()) :: %GroceryListItem{}
  def get_grocery_list_item!(id), do: GroceryListItem |> preload(:grocery_list) |> Repo.get!(id)

  @spec create_grocery_list_item(map()) ::
          {:ok, %GroceryListItem{}} | {:error, Ecto.Changeset.t()}
  def create_grocery_list_item(attrs \\ %{}) do
    %GroceryListItem{}
    |> GroceryListItem.changeset(attrs)
    |> Repo.insert()
  end

  @spec create_grocery_list_item!(map()) :: %GroceryListItem{}
  def create_grocery_list_item!(attrs \\ %{}) do
    %GroceryListItem{}
    |> GroceryListItem.changeset(attrs)
    |> Repo.insert!()
  end

  @spec update_grocery_list_item(%GroceryListItem{}, map()) ::
          {:ok, %GroceryListItem{}} | {:error, Ecto.Changeset.t()}
  def update_grocery_list_item(%GroceryListItem{} = grocery_list_item, attrs) do
    grocery_list_item
    |> GroceryListItem.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_grocery_list_item(%GroceryListItem{}) ::
          {:ok, %GroceryList{}} | {:error, Ecto.Changeset.t()}
  def delete_grocery_list_item(%GroceryListItem{} = grocery_list_item) do
    Repo.delete(grocery_list_item)
  end

  @spec delete_grocery_list_items(integer()) :: {integer(), nil | [term()]}
  def delete_grocery_list_items(grocery_list_id) do
    Queries.grocery_list_grocery_list_items(grocery_list_id)
    |> Repo.delete_all()
  end
end
