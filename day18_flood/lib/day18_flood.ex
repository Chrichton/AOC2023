defmodule Day18Flood do
  defmodule Command do
    defstruct [:direction, :distance, :color_code]

    def new(direction, distance, color_code) do
      %Command{direction: direction, distance: distance, color_code: color_code}
    end
  end

  alias Day18Flood.Command

  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    [direction, distance, color_code] = String.split(line, " ")

    distance = String.to_integer(distance)
    color_code = String.slice(color_code, 1, String.length(color_code) - 2)
    Command.new(direction, distance, color_code)
  end

  def solve(input) do
    trench_map =
      input
      |> read_input()
      |> Enum.reduce(
        {{0, 0}, MapSet.new([{0, 0}])},
        fn %Command{direction: direction, distance: distance}, {last_position, positions} ->
          {last_position, next_positions} = next_positions(last_position, direction, distance)
          {last_position, MapSet.union(positions, MapSet.new(next_positions))}
        end
      )
      |> elem(1)
      |> IO.inspect(limit: :infinity)

    # {{x_min, y_min}, {x_max, y_max}} =
    #   Enum.min_max(MapSet.to_list(trench_map))

    {{y0, x0}, {y1, x1}} = bounds(trench_map)

    start =
      {y0 - 1, x0 - 1}
      |> IO.inspect()

    # bounds(trench_map)
    # |> IO.inspect()

    # next_step([start], MapSet.new([]), trench_map)
  end

  def bounds(map) do
    {{y0, _}, {y1, _}} = Enum.min_max(map)
    {{_, x0}, {_, x1}} = Enum.min_max_by(map, fn {_, x} -> x end)
    {{y0, x0}, {y1, x1}}
  end

  def next_step([], visited, trench_map),
    do: Enum.count(trench_map) + Enum.count(visited)

  def next_step(coords, visited, trench_map) do
    coords
    |> Enum.reduce({[], visited}, fn coord, {acc_coords, acc_visited} ->
      neighbors(coord, visited, trench_map)
      |> Enum.reduce({acc_coords, acc_visited}, fn coord, {acc_coords2, acc_visited2} ->
        {[coord | acc_coords2], MapSet.put(acc_visited2, coord)}
      end)
    end)
    |> then(fn {new_coords, new_visted} ->
      next_step(new_coords, new_visted, trench_map)
    end)
  end

  def neighbors({x, y}, visited, trench_map) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x - 1, y},
      {x + 1, y},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y + 1}
    ]
    |> Enum.reject(fn neighbor ->
      MapSet.member?(visited, neighbor) or
        MapSet.member?(trench_map, neighbor)
    end)

    # |> MapSet.new()
    # |> MapSet.difference(visited)
    # |> MapSet.difference(trench_map)
  end

  def next_positions(last_position, direction, distance) do
    case direction do
      "R" -> next_x_positions(last_position, distance, fn n, m -> n + m end)
      "L" -> next_x_positions(last_position, distance, fn n, m -> n - m end)
      "U" -> next_y_positions(last_position, distance, fn n, m -> n - m end)
      "D" -> next_y_positions(last_position, distance, fn n, m -> n + m end)
    end
  end

  defp next_x_positions({x_last, y_last}, distance, sum_func) do
    next_positions =
      Enum.reduce(1..distance, [], fn summand, acc ->
        [{sum_func.(x_last, summand), y_last} | acc]
      end)

    last_position = hd(next_positions)
    {last_position, next_positions}
  end

  defp next_y_positions({x_last, y_last}, distance, sum_func) do
    next_positions =
      Enum.reduce(1..distance, [], fn summand, acc ->
        [{x_last, sum_func.(y_last, summand)} | acc]
      end)

    last_position = hd(next_positions)
    {last_position, next_positions}
  end
end
