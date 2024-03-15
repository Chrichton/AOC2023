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

  def shoelace([start_vertex | _rest] = vertices) do
    (vertices ++ [start_vertex])
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.map(fn [{x_i, y_i}, {x_i_plus_1, y_i_plus_1}] ->
      x_i * y_i_plus_1 - x_i_plus_1 * y_i
    end)
    |> Enum.sum()
    |> abs()
    |> div(2)
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

    vertices =
      input
      |> read_input()
      |> Enum.reduce(
        {{0, 0}, [{0, 0}]},
        fn %Command{direction: direction, distance: distance}, {last_position, positions} ->
          next_position = next_position(last_position, direction, distance)
          {next_position, [next_position | positions]}
        end
      )
      |> elem(1)

    directions2 = %{
      "L" => {0, -1},
      "R" => {0, 1},
      "U" => {-1, 0},
      "D" => {1, 0}
    }

    vertices2 =
      for %Command{direction: direction, distance: distance} <- read_input(input),
          reduce: [{0, 0}] do
        [{x, y} | _] = acc ->
          {dx, dy} = directions2[direction]
          next_pos = {x + dx * distance, y + dy * distance}
          [next_pos | acc]
      end

    area =
      vertices2
      |> Stream.chunk_every(2, 1, :discard)
      |> Stream.map(fn [{i1, j1}, {i2, j2}] ->
        (i1 - i2) * (j1 + j2)
      end)
      |> Enum.sum()
      |> div(2)
      |> abs()

    perimeter =
      input
      |> read_input()
      |> Enum.map(fn %Command{distance: distance} -> distance end)
      |> Enum.sum()

    inner_area = shoelace(vertices2)

    perimeter + inner_area

    area + div(perimeter, 2) + 1
  end

  def bounds(map) do
    {{y0, _}, {y1, _}} = Enum.min_max(map)
    {{_, x0}, {_, x1}} = Enum.min_max_by(map, fn {_, x} -> x end)
    {{y0, x0}, {y1, x1}}
  end

  def next_step([], visited, _trench_map, _bounds),
    do: visited

  def next_step(coords, visited, trench_map, bounds) do
    coords
    |> Enum.reduce({[], visited}, fn coord, {acc_coords, acc_visited} ->
      neighbors(coord, visited, trench_map, bounds)
      |> Enum.reduce({acc_coords, acc_visited}, fn coord, {acc_coords2, acc_visited2} ->
        {[coord | acc_coords2], MapSet.put(acc_visited2, coord)}
      end)
    end)
    |> then(fn {new_coords, new_visted} ->
      next_step(new_coords, new_visted, trench_map, bounds)
    end)
  end

  def neighbors({x, y}, visited, trench_map, {{y0, x0}, {y1, x1}}) do
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
      y < y0 or y > y1 or x < x0 or x > x1 or
        MapSet.member?(visited, neighbor) or
        MapSet.member?(trench_map, neighbor)
    end)

    # |> MapSet.new()
    # |> MapSet.difference(visited)
    # |> MapSet.difference(trench_map)
  end

  def next_position({x, y} = _last_position, direction, distance) do
    case direction do
      "R" -> {x + distance, y}
      "L" -> {x - distance, y}
      "U" -> {x, y - distance}
      "D" -> {x, y + distance}
    end
  end

  def next_positions(last_position, direction, distance) do
    case direction do
      "R" -> next_x_positions(last_position, distance, fn n, m -> n + m end)
      "L" -> next_x_positions(last_position, distance, fn n, m -> n - m end)
      "U" -> next_y_positions(last_position, distance, fn n, m -> n - m end)
      "D" -> next_y_positions(last_position, distance, fn n, m -> n + m end)
    end
  end

  def next_x_positions({x_last, y_last}, distance, sum_func) do
    next_positions =
      Enum.reduce(1..distance, [], fn summand, acc ->
        [{sum_func.(x_last, summand), y_last} | acc]
      end)

    last_position = hd(next_positions)
    {last_position, next_positions}
  end

  def next_y_positions({x_last, y_last}, distance, sum_func) do
    next_positions =
      Enum.reduce(1..distance, [], fn summand, acc ->
        [{x_last, sum_func.(y_last, summand)} | acc]
      end)

    last_position = hd(next_positions)
    {last_position, next_positions}
  end
end
