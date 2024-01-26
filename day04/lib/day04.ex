defmodule Day04 do
  def solve1(filename) do
    filename
    |> read_input()
    |> Enum.map(&calc_points/1)
    |> Enum.sum()
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

  def calc_my_winning_numbers_count({winning_numbers_map_set, my_numbers_map_set}) do
    MapSet.intersection(winning_numbers_map_set, my_numbers_map_set)
    |> Enum.count()
  end

  def calc_points({winning_numbers_map_set, my_numbers_map_set}) do
    {winning_numbers_map_set, my_numbers_map_set}
    |> calc_my_winning_numbers_count()
    |> power2()
  end

  def power2(0), do: 0

  def power2(n) do
    Integer.pow(2, n - 1)
  end

  # --------------------------------------

  def solve2(filename) do
    map_sets =
      filename
      |> read_input()

    card_counts_map =
      map_sets
      |> Enum.count()
      |> create_card_count_map()

    map_sets
    |> Enum.zip(1..Enum.count(map_sets))
    |> Enum.reduce(card_counts_map, fn
      {{winning_numbers_map_set, my_numbers_map_set}, card_no}, acc ->
        winners = calc_my_winning_numbers_count({winning_numbers_map_set, my_numbers_map_set})

        if winners > 0 do
          increment_card_counts(
            acc,
            Range.new(card_no + 1, card_no + winners),
            Map.get(acc, card_no)
          )
        else
          acc
        end
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def increment_card_counts(card_counts_map, range, increment) do
    range
    |> Enum.reduce(card_counts_map, fn card_no, acc ->
      Map.update(acc, card_no, increment, fn old_value ->
        old_value + increment
      end)
    end)
  end

  def create_card_count_map(card_count) do
    for n <- 1..card_count, into: %{}, do: {n, 1}
  end
end
