defmodule AnyGymPlanner.Pagination do
  alias AnyGymPlanner.Repo

  @spec paginate(Ecto.Query.t(), integer(), integer()) :: Scrivener.Page.t()
  def paginate(queryable, limit, offset) do
    params = get_scrivener_params(limit, offset)
    Repo.paginate(queryable, params)
  end

  @spec get_scrivener_params(integer(), integer()) :: %{
          page_size: integer(),
          page: integer()
        }
  def get_scrivener_params(limit, skip) do
    entry_end = skip + limit
    page_size = entry_end - skip
    page = div(entry_end, page_size)

    %{"page_size" => page_size, "page" => page}
  end
end
