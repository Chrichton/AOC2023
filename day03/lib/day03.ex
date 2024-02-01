# # See AOC2021 day9.ex, day11.ex

defmodule Day03 do
  def solve(filename) do
    filename
    |> read_input()
    |> find_valid_part_numbers()
    |> Enum.map(fn {part_number, _position} -> part_number end)
    |> Enum.sum()
  end

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> find_numbers_and_symbols()
  end

  def find_numbers_and_symbols(lines) do
    Enum.zip(lines, 0..(Enum.count(lines) - 1))
    |> Enum.reduce({[], MapSet.new(), ""}, fn {line, y_index},
                                              {number_strings_pos, symbols_mapset, number_string} ->
      line_chars = String.codepoints(line)
      x_indexes = 0..(String.length(line) - 1) |> Enum.to_list()
      look_ahead_chars = Enum.drop(line_chars, 1) ++ ["."]

      line_chars
      |> zip3(x_indexes, look_ahead_chars)
      |> Enum.reduce(
        {number_strings_pos, symbols_mapset, number_string},
        fn {char, x_index, look_ahead_char},
           {number_strings_pos, symbols_mapset, number_string} ->
          if number_char?(char) do
            number_string = number_string <> char

            if number_char?(look_ahead_char) do
              {number_strings_pos, symbols_mapset, number_string}
            else
              number_strings_pos =
                [{number_string, {x_index, y_index}} | number_strings_pos]

              number_string = ""
              {number_strings_pos, symbols_mapset, number_string}
            end
          else
            if symbol?(char) do
              symbols_mapset = MapSet.put(symbols_mapset, {x_index, y_index})
              {number_strings_pos, symbols_mapset, number_string}
            else
              {number_strings_pos, symbols_mapset, number_string}
            end
          end
        end
      )
    end)
  end

  def find_valid_part_numbers({number_strings_pos, symbols_mapset, _}) do
    number_strings_pos
    |> Enum.reduce([], fn {number_string, {x, y}}, parts_pos ->
      if number_string
         |> get_neighbors({x, y})
         |> MapSet.intersection(symbols_mapset) == MapSet.new(),
         do: parts_pos,
         else: [{String.to_integer(number_string), {x, y}} | parts_pos]
    end)
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

  def solve2(filename) do
    lines =
      filename
      |> File.read!()
      |> String.split("\n")

    parts_pos =
      lines
      |> find_numbers_and_symbols()
      |> then(fn {number_string_pos, _symbols_mapset, _} -> number_string_pos end)

    find_cogs(lines)
    |> Enum.reduce(0, fn {x, y}, acc ->
      neighbor_parts =
        get_neigbor_parts(parts_pos, {x, y})

      if Enum.count(neighbor_parts) == 2,
        do: acc + multiply(neighbor_parts),
        else: acc
    end)
  end

  def find_cogs(lines) do
    for {line, y_index} <- Enum.with_index(lines),
        chars = String.codepoints(line),
        x_index_max = Enum.count(chars) - 1,
        {char, x_index} <- Enum.zip(chars, 0..x_index_max),
        char == "*",
        reduce: MapSet.new() do
      acc -> MapSet.put(acc, {x_index, y_index})
    end
  end

  # def find_cogs(lines) do
  #   Enum.zip(lines, 0..(Enum.count(lines) - 1))
  #   |> Enum.reduce(MapSet.new(), fn {line, y_index}, acc ->
  #     line_chars = String.codepoints(line)
  #     x_indexes = 0..(String.length(line) - 1) |> Enum.to_list()

  #     Enum.zip(line_chars, x_indexes)
  #     |> Enum.reduce(acc, fn {char, x_index}, acc ->
  #       if char == "*",
  #         do: MapSet.put(acc, {x_index, y_index}),
  #         else: acc
  #     end)
  #   end)
  # end

  def get_neigbor_parts(parts_pos, {x, y}) do
    parts_pos
    |> Enum.reduce([], fn {part_number, pos}, acc ->
      if MapSet.member?(get_neighbors(part_number, pos), {x, y}),
        do: [part_number | acc],
        else: acc
    end)
  end

  def multiply([number_string1, number_string2]) do
    String.to_integer(number_string1) * String.to_integer(number_string2)
  end
end
