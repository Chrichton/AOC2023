# See AOC2021 day9.ex, day11.ex

defmodule Day03 do
  def solve(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Enum.with_index(fn line, y_index ->
      line_chars = String.codepoints(line)
      index_numbers = 0..(String.length(line) - 1) |> Enum.to_list()
      look_ahead_chars = Enum.drop(line_chars, 1) ++ ["."]

      line_chars
      |> zip3(index_numbers, look_ahead_chars)
      |> Enum.reduce(
        {%{}, MapSet.new(), ""},
        fn {char, x_index, look_ahead_char},
           {number_strings_map, symbols_mapset, number_string} ->
          if number_char?(char) do
            number_string = number_string <> char

            if number_char?(look_ahead_char) do
              {number_strings_map, symbols_mapset, number_string}
            else
              number_strings_map = Map.put(number_strings_map, number_string, {x_index, y_index})
              number_string = ""
              {number_strings_map, symbols_mapset, number_string}
            end
          else
            if symbol?(char) do
              symbols_mapset = MapSet.put(symbols_mapset, {x_index, y_index})
              {number_strings_map, symbols_mapset, number_string}
            else
              {number_strings_map, symbols_mapset, number_string}
            end
          end
        end
      )
    end)
    |> Enum.reduce({%{}, MapSet.new()}, fn {number_strings_map, symbols_mapset, _},
                                           {acc_map, acc_map_set} ->
      {Map.merge(acc_map, number_strings_map), MapSet.union(acc_map_set, symbols_mapset)}
    end)
    |> find_valid_part_numbers()
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def find_valid_part_numbers({number_strings_map, symbols_mapset}) do
    number_strings_map
    |> Map.reject(fn {number_string, {x, y}} ->
      number_string
      |> get_neighbors({x, y})
      |> MapSet.intersection(symbols_mapset) == MapSet.new()
    end)
    |> Map.keys()
  end

  def get_neighbors(part_number, {x, y}) do
    (x - String.length(part_number) + 1)..x
    |> Enum.reduce(MapSet.new(), fn x_char, acc ->
      MapSet.union(acc, get_neighbors({x_char, y}))
    end)
  end

  def get_neighbors({x, y}) do
    [
      {x - 1, y},
      {x + 1, y},
      {x, y - 1},
      {x, y + 1},
      {x - 1, y - 1},
      {x + 1, y + 1},
      {x - 1, y + 1},
      {x + 1, y - 1}
    ]
    |> MapSet.new()
  end

  def number_char?(char) do
    number_chars =
      0..9 |> Enum.to_list() |> Enum.map(&Integer.to_string/1)

    char in number_chars
  end

  def symbol?(char), do: not number_char?(char) and char != "."

  def zip3([], _, _), do: []
  def zip3([x | xs], [y | ys], [z | zs]), do: [{x, y, z} | zip3(xs, ys, zs)]
end
