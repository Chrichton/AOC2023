defmodule Day10 do
  def read_input(input) do
    input =
      input
      |> File.read!()

    lines = String.split(input, "\n")
    y_range = 0..(Enum.count(lines) - 1)

    locations_pipes_map =
      for {y_index, line} <- Enum.zip(y_range, lines),
          chars = String.codepoints(line),
          {x_index, char} <- Enum.zip(0..(Enum.count(chars) - 1), chars),
          char != ".",
          reduce: %{} do
        acc -> Map.put(acc, {x_index, y_index}, char_to_pipe(char))
      end

    [start_position] =
      locations_pipes_map
      |> Map.filter(fn {_coord, char} -> char == "S" end)
      |> Map.keys()

    {start_position, locations_pipes_map}
  end

  def char_to_pipe(char) do
    case char do
      "|" -> [:north, :south]
      "-" -> [:east, :west]
      "L" -> [:north, :east]
      "J" -> [:north, :west]
      "7" -> [:south, :west]
      "F" -> [:south, :east]
      "S" -> "S"
    end
  end

  def solve(input) do
    input
    |> read_input()
    |> then(fn {start_coord, pipes} ->
      steps(nil, start_coord, pipes, start_coord, 0)
    end)
  end

  def steps(direction_from, start_coord, _pipes, end_coord, count)
      when start_coord == end_coord and direction_from != nil,
      do: div(count, 2)

  def steps(direction_from, coord, pipes, end_coord, count) do
    {direction, next_coord} =
      if direction_from == nil,
        do: next_coord(coord, pipes),
        else: next_coord(coord, direction_from, pipes)

    steps(direction, next_coord, pipes, end_coord, count + 1)
  end

  def next_coord(coord, pipes) do
    neighbors(coord)
    |> Enum.reduce_while(:none, fn neighbor_coord, acc ->
      case Map.fetch(pipes, neighbor_coord) do
        :error ->
          {:cont, acc}

        {:ok, [direction1, direction2]} ->
          direction_from = direction_from(coord, neighbor_coord)

          if direction_from == direction1 or direction_from == direction2,
            do: {:halt, {direction_from, neighbor_coord}},
            else: {:cont, acc}
      end
    end)
  end

  def next_coord(coord, direction_from, pipes) do
    [direction1, direction2] = Map.get(pipes, coord)

    if direction_from == direction1,
      do: {opposite_direction(direction2), direction_to_coord(direction2, coord)},
      else: {opposite_direction(direction1), direction_to_coord(direction1, coord)}
  end

  def neighbors({x, y}) do
    [{x - 1, y}, {x + 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.reject(fn {x, y} -> x < 0 or y < 0 end)
  end

  def direction_from({x_from, y_from}, {x_to, y_to}) do
    cond do
      x_from < x_to -> :west
      x_from > x_to -> :east
      y_from < y_to -> :north
      y_from > y_to -> :south
    end
  end

  def direction_to_coord(direction, {from_x, from_y}) do
    cond do
      direction == :north -> {from_x, from_y - 1}
      direction == :south -> {from_x, from_y + 1}
      direction == :west -> {from_x - 1, from_y}
      direction == :east -> {from_x + 1, from_y}
    end
  end

  def opposite_direction(direction) do
    cond do
      direction == :north -> :south
      direction == :south -> :north
      direction == :west -> :east
      direction == :east -> :west
    end
  end
end
