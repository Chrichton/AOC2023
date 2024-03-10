defmodule Day18 do
  defmodule Command do
    defstruct [:direction, :distance, :color_code]

    def new(direction, distance, color_code) do
      %Command{direction: direction, distance: distance, color_code: color_code}
    end
  end

  alias Day18.Command

  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def solve(input) do
    input
    |> read_input()
    |> Enum.reduce(
      {{0, 0}, MapSet.new([{0, 0}])},
      fn %Command{direction: direction, distance: distance}, {last_position, positions} ->
        next_position = next_position(last_position, direction, distance)
        {next_position, MapSet.put(positions, next_position)}
      end
    )
  end

  def next_position({x_last, y_last}, direction, distance) do
    case direction do
      "R" -> {x_last + distance, y_last}
      "L" -> {x_last - distance, y_last}
      "U" -> {x_last, y_last - distance}
      "D" -> {x_last, y_last + distance}
    end
  end

  def parse_line(line) do
    [direction, distance, color_code] = String.split(line, " ")

    distance = String.to_integer(distance)
    color_code = String.slice(color_code, 1, String.length(line) - 6)
    Command.new(direction, distance, color_code)
  end
end
