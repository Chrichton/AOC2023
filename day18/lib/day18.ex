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

  def parse_line(line) do
    [direction, distance, color_code] = String.split(line, " ")

    distance = String.to_integer(distance)
    color_code = String.slice(color_code, 1, String.length(line) - 6)
    Command.new(direction, distance, color_code)
  end

  def solve(input) do
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
