defmodule Day08 do
  def read_input(input) do
    input = File.read!(input)

    [direction_string | [_blank_line | from_tos]] = String.split(input, "\n")

    directions =
      direction_string
      |> String.codepoints()
      |> Stream.cycle()

    left_rights =
      Enum.map(from_tos, fn from_to ->
        [from, to] = String.split(from_to, " = (")
        [left, right] = String.split(to, ", ")
        right = String.replace(right, ")", "")
        {from, {left, right}}
      end)
      |> Map.new()

    {directions, left_rights}
  end

  def solve(input) do
    input
    |> read_input()
    |> then(fn {directions, left_rights} ->
      Enum.reduce_while(directions, {"AAA", 1}, fn direction, {from, steps} ->
        destination = destination(from, direction, left_rights)

        if destination == "ZZZ",
          do: {:halt, steps},
          else: {:cont, {destination, steps + 1}}
      end)
    end)
  end

  def destination(from, left_right, left_rights) do
    left_right_pair = Map.get(left_rights, from)

    if left_right == "L",
      do: elem(left_right_pair, 0),
      else: elem(left_right_pair, 1)
  end
end
