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
    color_code = String.slice(color_code, 2, String.length(color_code) - 3)
    Command.new(direction, distance, color_code)
  end

  def solve(input, read_input_func) do
    vertices =
      input
      |> read_input_func.()
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
      |> read_input_func.()
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

  # ----------------------------------------------------------------------------

  def read_input2(input) do
    input
    |> read_input()
    |> Enum.map(fn %Command{color_code: color_code} ->
      {direction, distance} = parse_color_code(color_code)
      %Command{direction: direction, distance: distance}
    end)
  end

  def parse_color_code(string) do
    direction =
      string
      |> String.last()
      |> hex_digit_to_direction()

    distance =
      string
      |> String.slice(0, 5)
      |> hex_digits_to_distance()

    {direction, distance}
  end

  defp hex_digits_to_distance(digits), do: String.to_integer(digits, 16)

  defp hex_digit_to_direction(digit) do
    case digit do
      "0" -> "R"
      "1" -> "D"
      "2" -> "L"
      "3" -> "U"
    end
  end
end
