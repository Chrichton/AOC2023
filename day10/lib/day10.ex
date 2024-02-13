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
    |> steps()
  end

  def steps({start_coord, pipes}) do
    neighbor_pipes(start_coord, pipes)
  end

  def neighbor_pipes(coord, pipes) do
    neighbors(coord)
    |> Enum.map(&Map.get(pipes, &1))
    |> Enum.reject(&(&1 == nil))
  end

  def neighbors({x, y}) do
    [{x - 1, y}, {x + 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.reject(fn {x, y} -> x < 0 or y < 0 end)
  end
end
