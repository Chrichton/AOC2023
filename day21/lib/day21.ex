defmodule Day21 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> lines_to_map()
  end

  def solve(input) do
    input
    |> read_input()
    |> process_steps()
  end

  def process_steps(point_char_map) do
    start = find_startpoint(point_char_map)

    next_step(MapSet.new([start]), MapSet.new(), point_char_map, 1)
  end

  def next_step(last_points, visited, _point_char_map, steps) when steps == 3,
    do: MapSet.union(last_points, visited)

  def next_step(last_points, visited, point_char_map, steps) do
    new_points =
      Enum.reduce(last_points, MapSet.new(), fn point, acc ->
        neighbors =
          point
          |> neighbors()
          |> MapSet.filter(&(Map.get(point_char_map, &1) == "."))

        # |> MapSet.union(acc)

        # |> MapSet.difference(visited)
        # |> MapSet.difference(acc)
      end)
      |> IO.inspect(label: "new pointa")

    next_step(
      new_points,
      MapSet.union(last_points, new_points),
      point_char_map,
      steps + 1
    )
  end

  def find_startpoint(point_char_map) do
    Map.filter(point_char_map, fn {_point, char} -> char == "S" end)
    |> Map.keys()
    |> hd()
  end

  def lines_to_map(lines) do
    for {line, y_index} <- Enum.with_index(lines),
        {char, x_index} <- Enum.with_index(String.codepoints(line)),
        into: %{},
        do: {{x_index, y_index}, char}
  end

  def neighbors({x, y}) do
    [{x - 1, y}, {x + 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.reject(fn {x, y} -> x < 0 or y < 0 end)
    |> MapSet.new()
  end
end
