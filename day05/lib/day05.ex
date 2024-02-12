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
    maps
    |> Enum.reduce(src, fn ranges, acc ->
      find_destination(acc, ranges)
    end)
  end

  def find_destination(src, ranges) do
    ranges
    |> Enum.reduce_while(src, fn [dest_start, src_start, length], _acc2 ->
      case find_dest(src, dest_start, src_start, length) do
        nil -> {:cont, src}
        dest -> {:halt, dest}
      end
    end)
  end

  def find_dest(src, dest_start, src_start, lenght) do
    dest = src - src_start + dest_start

    if in_range?(src, src_start, lenght) and
         in_range?(dest, dest_start, lenght),
       do: dest,
       else: nil
  end

  def in_range?(value, range_start, lenght),
    do: value >= range_start and value <= range_start + lenght - 1
end
