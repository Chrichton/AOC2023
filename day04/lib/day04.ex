defmodule Day04 do
  def solve1(filename) do
    filename
    |> read_input()
    |> calc_points()
  end

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [_card, numbers] = String.split(line, ": ", trim: true)
      [winning_numbers, my_numbers] = String.split(numbers, " | ", trim: true)

      {create_numbers_map_set(winning_numbers), create_numbers_map_set(my_numbers)}
    end)
  end

  defp create_numbers_map_set(number_strings) do
    number_strings
    |> String.split(" ", trim: true)
    |> Enum.map(fn number_string ->
      number_string
      |> String.trim()
      |> String.to_integer()
    end)
    |> MapSet.new()
  end

  def calc_points(map_sets) do
    map_sets
    |> Enum.map(fn {winning_numbers_map_set, my_numbers_map_set} ->
      MapSet.intersection(winning_numbers_map_set, my_numbers_map_set)
      |> Enum.count()
      |> power2()
    end)
    |> Enum.sum()
  end

  def power2(0), do: 0
  def power2(n) do
    Integer.pow(2, n - 1)
  end    
end
