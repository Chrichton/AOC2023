defmodule Day05 do
  def read_input(input) do
    input = File.read!(input)

    [seeds | rest] = String.split(input, "\n\n")
    [_, seeds] = String.split(seeds, ": ")
    seeds = parse_numbers_string(seeds)
    maps = parse_maps_strings(rest)

    {seeds, maps}
  end

  def parse_maps_strings(maps_strings) do
    Enum.flat_map(maps_strings, &parse_map/1)
  end

  def parse_map(map_string) do
    [_ | rest] = String.split(map_string, ":\n")

    Enum.map(rest, fn number_strings ->
      number_strings
      |> String.split("\n")
      |> Enum.map(&parse_numbers_string/1)
    end)
  end

  def parse_numbers_string(numbers) do
    numbers
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  def solve(input) do
    {seeds, maps} = read_input(input)

    seeds
    |> Enum.map(&find_location(&1, maps))
    |> Enum.min()
  end

  def find_location(src, maps) do
    IO.inspect(src, label: "seed stated")

    maps
    |> Enum.reduce(src, fn ranges, acc ->
      find_destination(acc, ranges)
    end)
  end

  def find_destination(src, ranges) do
    ranges
    |> Enum.reduce_while(src, fn [dest_start, src_start, length], _acc2 ->
      src_range = src_start..(src_start + length - 1)
      dest_range = dest_start..(dest_start + length - 1)

      case Enum.find_index(src_range, &(&1 == src)) do
        nil -> {:cont, src}
        src_index -> {:halt, Enum.at(dest_range, src_index)}
      end
    end)
  end
end
