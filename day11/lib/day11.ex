defmodule Day11 do
  def read_input(input) do
    universe =
      input
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.codepoints/1)

    galaxies =
      for {line, y_index} <- Enum.with_index(universe),
          x_index_max = Enum.count(line) - 1,
          {char, x_index} <- Enum.zip(line, 0..x_index_max),
          char != ".",
          reduce: [] do
        acc -> [{x_index, y_index} | acc]
      end

    max_x_index =
      universe
      |> List.first()
      |> Enum.count()
      |> Kernel.-(1)

    max_y_index = Enum.count(universe) - 1

    horizontal_lines = find_horizontal_lines(universe)
    horizontal_line_positions = horizontal_lines_to_positions(horizontal_lines, max_x_index)

    vertical_lines = find_horizontal_lines(universe |> transpose())
    vertical_line_positions = vertical_lines_to_positions(vertical_lines, max_y_index)

    {galaxies, MapSet.union(horizontal_line_positions, vertical_line_positions)}
  end

  def horizontal_lines_to_positions(horizontal_lines, max_x_index) do
    horizontal_lines
    |> Enum.reduce(MapSet.new(), fn y_index, acc ->
      Enum.reduce(0..max_x_index, acc, fn x_index, acc2 ->
        MapSet.put(acc2, {x_index, y_index})
      end)
    end)
  end

  def vertical_lines_to_positions(vertical_lines, max_y_index) do
    vertical_lines
    |> Enum.reduce(MapSet.new(), fn x_index, acc ->
      Enum.reduce(0..max_y_index, acc, fn y_index, acc2 ->
        MapSet.put(acc2, {x_index, y_index})
      end)
    end)
  end

  def solve(input, factor) do
    {galaxies, lines} = read_input(input)

    galaxies
    |> Combination.combine(2)
    |> Enum.map(fn [{x1, y1}, {x2, y2}] ->
      path = Day11.path({x1, y1}, {x2, y2})
      line_hits = MapSet.intersection(path, lines)
      Enum.count(path) + Enum.count(line_hits) * (factor - 1)
    end)
    |> Enum.sum()
  end

  def find_horizontal_lines(universe) do
    for {line, y_index} <- Enum.with_index(universe),
        Enum.all?(line, &(&1 == ".")),
        reduce: MapSet.new() do
      acc -> MapSet.put(acc, y_index)
    end
  end

  def path({x1, y1} = _from, {x2, y2} = _to) do
    map_set_x =
      for y <- y1..y2 |> Enum.drop(1),
          reduce: MapSet.new() do
        acc -> MapSet.put(acc, {x1, y})
      end

    for x <- x1..x2 |> Enum.drop(1),
        reduce: map_set_x do
      acc -> MapSet.put(acc, {x, y2})
    end
  end

  def comb(0, _), do: [[]]
  def comb(_, []), do: []

  def comb(m, [h | t]) do
    for(l <- comb(m - 1, t), do: [h | l]) ++ comb(m, t)
  end

  def transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
