defmodule AnyGymPlanner.Fraction do
  import AnyGymPlanner.Guards

  @spec is_fraction?(String.t()) :: boolean()
  def is_fraction?(num_string) do
    String.contains?(num_string, "/")
  end

  @spec extract_integer(String.t()) :: String.t()
  def extract_integer(mixed_num) do
    case {is_fraction?(mixed_num), String.contains?(mixed_num, " ")} do
      {false, _} -> mixed_num
      {_, false} -> ""
      _ -> mixed_num |> String.split(" ") |> Enum.at(0)
    end
  end

  @spec extract_fraction(String.t()) :: String.t()
  def extract_fraction(mixed_num) do
    case {is_fraction?(mixed_num), String.contains?(mixed_num, " ")} do
      {false, _} -> ""
      {_, false} -> mixed_num
      _ -> mixed_num |> String.split(" ") |> Enum.at(1)
    end
  end

  @spec extract_numerator(String.t()) :: String.t()
  def extract_numerator(mixed_num) do
    case extract_fraction(mixed_num) do
      "" -> extract_integer(mixed_num)
      extracted -> extracted |> String.split("/") |> Enum.at(0)
    end
  end

  @spec extract_denominator(String.t()) :: String.t()
  def extract_denominator(mixed_num) do
    case extract_fraction(mixed_num) do
      "" -> if mixed_num == "", do: "", else: "1"
      extracted -> extracted |> String.split("/") |> Enum.at(1)
    end
  end

  @spec to_rounded_fraction(float(), integer()) :: String.t()
  def to_rounded_fraction(num, max_denominator) do
    rounded_num = round_to_nearest_fraction(num, max_denominator)
    whole_num = Float.floor(rounded_num / 1) |> round()
    fraction_str = (rounded_num - whole_num) |> Float.ratio() |> build_fraction_str()
    whole_num_str = build_whole_num_str(whole_num)

    build_mixed_num_str(whole_num_str, fraction_str)
  end

  @spec build_whole_num_str(integer()) :: String.t()
  defp build_whole_num_str(0), do: ""
  defp build_whole_num_str(num), do: Integer.to_string(num)

  @spec build_fraction_str({integer(), integer()}) :: String.t()
  defp build_fraction_str({_, 1}), do: ""
  defp build_fraction_str({0, _}), do: ""

  defp build_fraction_str(ratio) do
    ratio |> Tuple.to_list() |> Enum.join("/")
  end

  @spec build_mixed_num_str(String.t(), String.t()) :: String.t()
  defp build_mixed_num_str("", ""), do: "0"
  defp build_mixed_num_str("", fraction), do: fraction
  defp build_mixed_num_str(whole_num, ""), do: whole_num
  defp build_mixed_num_str(whole_num, fraction), do: "#{whole_num} #{fraction}"

  @spec fraction_to_float(String.t() | nil) :: Float.t()
  def fraction_to_float(fraction) when is_empty(fraction), do: 0.0

  def fraction_to_float(fraction) do
    case String.contains?(fraction, "/") do
      true ->
        {whole_num, _} =
          case String.contains?(fraction, " ") do
            true ->
              fraction |> String.split(" ") |> Enum.at(0) |> Float.parse()

            false ->
              {0, ""}
          end

        nums = String.split(fraction, "/")
        {numerator, _} = Float.parse(Enum.at(nums, 0))
        {denominator, _} = Float.parse(Enum.at(nums, 1))
        whole_num + numerator / denominator

      false ->
        case Float.parse(fraction) do
          :error -> binary_to_float(fraction)
          {num, _} -> num
        end
    end
  end

  @spec binary_to_fraction(String.t()) :: String.t()
  def binary_to_fraction(binary) do
    codepoint =
      case binary do
        <<num>> ->
          Integer.to_string(num)

        _ ->
          binary |> to_charlist() |> Enum.at(0) |> Integer.to_string()
      end

    fraction_codepoints = %{
      "189" => "1/2",
      "8531" => "1/3",
      "8532" => "2/3",
      "188" => "1/4",
      "190" => "3/4",
      "8533" => "1/5",
      "8534" => "2/5",
      "8535" => "3/5",
      "8536" => "4/5",
      "8537" => "1/6",
      "8538" => "5/6",
      "8528" => "1/7",
      "8539" => "1/8",
      "155" => "1/8",
      "8540" => "3/8",
      "8541" => "5/8",
      "8542" => "7/8",
      "8529" => "1/9",
      "8530" => "1/10"
    }

    Map.fetch(fraction_codepoints, codepoint)
  end

  @spec binary_to_float(String.t()) :: Float.t()
  def binary_to_float(binary) do
    case binary_to_fraction(binary) do
      {:ok, fraction} ->
        fraction_to_float(fraction)

      :error ->
        nil
    end
  end

  @spec round_to_nearest_fraction(float(), integer()) :: float()
  def round_to_nearest_fraction(num, denominator) do
    rounded = Float.round(num * denominator)
    rounded / denominator
  end

  @spec floor_to(integer() | float(), integer()) :: integer()
  def floor_to(num, divisor) do
    round(num) - rem(round(num), divisor)
  end

  @spec ceil_to(integer() | float(), integer()) :: integer()
  def ceil_to(num, divisor) do
    round(num) - (rem(round(num), divisor) - divisor)
  end

  @spec ceil_to_divisor(integer() | float(), integer()) :: float()
  def ceil_to_divisor(num, divisor) do
    :math.ceil(num * divisor) / divisor
  end

  @spec round_to_divisor(integer() | float(), integer()) :: float()
  def round_to_divisor(num, divisor) do
    round(num * divisor) / divisor
  end
end
