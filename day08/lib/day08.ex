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

  # ----------------------------------------------------------------

  def read_input2(input) do
    input = File.read!(input)

    [_direction_string | [_blank_line | from_tos]] = String.split(input, "\n")

    left_rights =
      Enum.map(from_tos, fn from_to ->
        [from, to] = String.split(from_to, " = (")
        [left, right] = String.split(to, ", ")
        right = String.replace(right, ")", "")
        {from, {left, right}}
      end)

    left_rights
  end

  def convert(left_rights) do
    left_rights
    |> Enum.reduce({[], %{}, %{}, %{}}, fn {from, {left, right}},
                                           {result, from_map, left_map, right_map} ->
      {from, from_map} = update(from, from_map)
      {left, left_map} = update(left, left_map)
      {right, right_map} = update(right, right_map)
      {[{from, {left, right}} | result], from_map, left_map, right_map}
    end)
    |> then(fn {result, _from_map, _left_map, _right_map} -> result end)
    |> Map.new()
  end

  def solve2(input) do
    input
    |> read_input()
    |> then(fn {directions, left_rights} ->
      starting_nodes =
        left_rights
        |> Map.keys()
        |> Enum.filter(&String.ends_with?(&1, "A"))

      directions
      |> Enum.reduce_while(
        {starting_nodes, 1},
        fn direction, {starting_nodes, steps} ->
          dest_nodes = destination2(starting_nodes, direction, left_rights)

          if Enum.all?(dest_nodes, &String.ends_with?(&1, "Z")),
            do: {:halt, steps},
            else: {:cont, {dest_nodes, steps + 1}}
        end
      )
    end)
  end

  def destination2(starting_nodes, direction, left_rights) do
    Enum.map(starting_nodes, fn node ->
      {left, right} = Map.get(left_rights, node)

      if direction == "L",
        do: left,
        else: right
    end)
  end

  def update(string, map) do
    last_char = String.last(string)
    map = Map.update(map, last_char, 1, fn count -> count + 1 end)

    count_char =
      map
      |> Map.get(last_char)
      |> Integer.to_string()

    {count_char <> count_char <> last_char, map}
  end
end
