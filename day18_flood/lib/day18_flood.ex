# First, I tried a flood_fill, but that took much too long
# and I aborted the idea

# Then I read about the shoelace-formula, a way to calculate the area of an
# polygon, defined by its vertices
# https://en.wikipedia.org/wiki/Shoelace_formula
# https://www.101computing.net/the-shoelace-algorithm/
#
# I implemented it and calculated the inner_area.
# To calculate the perimeter, I added all distances connecting the vertices.
# But as the perimeter runs through middle of the trench, I had to use half of
# the distances.

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

    perimeter =
      input
      |> read_input()
      |> Enum.map(fn %Command{distance: distance} -> distance end)
      |> Enum.sum()

    inner_area = shoelace(vertices)
    inner_area + div(perimeter, 2) + 1
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

  def next_position({x, y} = _last_position, direction, distance) do
    case direction do
      "R" -> {x + distance, y}
      "L" -> {x - distance, y}
      "U" -> {x, y - distance}
      "D" -> {x, y + distance}
    end
  end
end
