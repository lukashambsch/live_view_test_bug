defmodule AnyGymPlanner.Validators do
  import Ecto.Changeset

  @spec validate_one_of_required(Ecto.Changeset.t(), [atom()]) :: Ecto.Changeset.t()
  def validate_one_of_required(changeset, fields) do
    values = Enum.map(fields, fn field -> get_field(changeset, field) end)

    if Enum.all?(values, &is_nil/1) do
      Enum.reduce(fields, changeset, fn field, acc ->
        add_error(acc, field, "You must fill in at least one of the fields.")
      end)
    else
      changeset
    end
  end
end
