defmodule AnyGymPlanner.StringUtils do
  @spec title_case(String.t()) :: String.t()
  def title_case(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
