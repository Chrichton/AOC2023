defmodule Day10 do
  def read_input(input) do
    input =
      input
      |> File.read!()

    lines = String.split(input, "\n")
    y_range = 0..(Enum.count(lines) - 1)

    locations_map =
      for {y_index, line} <- Enum.zip(y_range, lines),
          chars = String.codepoints(line),
          {x_index, char} <- Enum.zip(0..(Enum.count(chars) - 1), chars),
          char != ".",
          reduce: %{} do
        acc -> Map.put(acc, {x_index, y_index}, char_to_pipe(char))
      end

    [start_position] =
      locations_map
      |> Map.filter(fn {_coord, char} -> char == "S" end)
      |> Map.keys()

    locations_pipes_map =
      locations_map
      |> Map.reject(fn {_coord, char} -> char == "S" end)

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
      start_coord = {3, 1}
      steps(start_coord, pipes, start_coord, 0)
    end)
  end

  def steps(start_coord, _pipes, end_coord, count)
      when start_coord == end_coord and count > 0,
      do: count

  def steps(start_coord, pipes, end_coord, count) do
    next_coord =
      next_coord(start_coord, pipes)
      |> IO.inspect(label: "next_coord")

    # steps(next_coord, pipes, end_coord, count + 1)
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
            do: {:halt, neighbor_coord},
            else: {:cont, acc}
      end
    end)
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
end
