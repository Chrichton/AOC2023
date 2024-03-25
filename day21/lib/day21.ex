defmodule Day21 do
  def read_input(input) do
    lines =
      input
      |> File.read!()
      |> String.split("\n")

    point_char_map = lines_to_map(lines)

    height = Enum.count(lines)

    width =
      lines
      |> Enum.at(0)
      |> String.length()

    {point_char_map, width, height}
  end

  def solve(input, max_steps) do
    input
    |> read_input()
    |> then(fn {point_char_map, width, height} ->
      process_steps(point_char_map, width, height, max_steps)
    end)
  end

  def process_steps(point_char_map, width, height, max_steps) do
    start = find_startpoint(point_char_map)

    next_step(MapSet.new([start]), point_char_map, width, height, 0, max_steps)
  end

  def next_step(last_points, _point_char_map, _width, _height, steps, max_steps)
      when steps == max_steps,
      do: Enum.count(last_points)

  def next_step(last_points, point_char_map, width, height, steps, max_steps) do
    new_points =
      Enum.reduce(last_points, MapSet.new(), fn point, acc ->
        point
        |> neighbors()
        |> MapSet.reject(&(get(point_char_map, &1, width, height) == "#"))
        |> MapSet.union(acc)
      end)

    next_step(
      new_points,
      point_char_map,
      width,
      height,
      steps + 1,
      max_steps
    )
  end

  def find_startpoint(point_char_map) do
    Map.filter(point_char_map, fn {_point, char} -> char == "S" end)
    |> Map.keys()
    |> hd()
  end

  def lines_to_map(lines) do
    for {line, y_index} <- Enum.with_index(lines),
        {char, x_index} <- Enum.with_index(String.codepoints(line)),
        into: %{},
        do: {{x_index, y_index}, char}
  end

  def neighbors({x, y}) do
    [{x - 1, y}, {x + 1, y}, {x, y + 1}, {x, y - 1}]
    |> MapSet.new()
  end

  # ----------------------------------------------------------------

  def get(point_char_map, {x, y}, width, height) do
    x_mod = modulo(x, width)
    y_mod = modulo(y, height)

    Map.get(point_char_map, {x_mod, y_mod})
  end

  def modulo(value, divisor) do
    if value < 0 and rem(value, divisor) != 0,
      do: rem(value, divisor) + abs(divisor),
      else: rem(value, divisor)
  end
end
