defmodule Day16 do
  def read_input(input) do
    lines =
      input
      |> File.read!()
      |> String.split("\n")

    {find_mirrors(lines), max_x_y(lines)}
  end

  def solve(input) do
    input
    |> read_input()
    |> next_step(MapSet.new([{{0, 0}, :east}]), MapSet.new([{{0, 0}, :east}]), 1)
  end

  def next_step({_mirrors, {_max_x, _max_y}}, _rays, visited, 0) do
    visited
    |> Enum.map(fn {position, _direction} -> position end)
    |> MapSet.new()
    |> MapSet.size()
  end

  def next_step({mirrors, {max_x, max_y}}, rays, visited, _rays_count) do
    rays
    |> Enum.reduce(
      {MapSet.new(), visited},
      fn ray, {acc_rays, acc_visited} ->
        next_rays =
          next_rays(ray, mirrors, max_x, max_y)
          |> MapSet.new()
          |> MapSet.difference(visited)

        next_visited = MapSet.new(next_rays)

        {MapSet.union(acc_rays, next_rays), MapSet.union(acc_visited, next_visited)}
      end
    )
    |> then(fn {new_rays, new_visited} ->
      next_step({mirrors, {max_x, max_y}}, new_rays, new_visited, Enum.count(new_rays))
    end)
  end

  def next_rays({{_x, _y} = position, direction} = ray, mirrors, max_x, max_y) do
    case Map.fetch(mirrors, position) do
      :error ->
        [next_ray(ray)]

      {:ok, "-"} ->
        if direction in [:west, :east] do
          [next_ray(ray)]
        else
          [next_ray({position, :west}), next_ray({position, :east})]
        end

      {:ok, "|"} ->
        if direction in [:north, :south] do
          [next_ray({position, direction})]
        else
          [next_ray({position, :north}), next_ray({position, :south})]
        end

      {:ok, "/"} ->
        case direction do
          :east ->
            [next_ray({position, :north})]

          :west ->
            [next_ray({position, :south})]

          :south ->
            [next_ray({position, :west})]

          :north ->
            [next_ray({position, :east})]
        end

      {:ok, "\\"} ->
        case direction do
          :east ->
            [next_ray({position, :south})]

          :west ->
            [next_ray({position, :north})]

          :south ->
            [next_ray({position, :east})]

          :north ->
            [next_ray({position, :west})]
        end
    end
    |> Enum.filter(fn {{x1, y1}, _direction} ->
      x1 in 0..max_x and y1 in 0..max_y
    end)
  end

  defp next_ray({{x, y}, direction} = _ray) do
    cond do
      direction == :north -> {{x, y - 1}, :north}
      direction == :south -> {{x, y + 1}, :south}
      direction == :west -> {{x - 1, y}, :west}
      direction == :east -> {{x + 1, y}, :east}
    end
  end

  defp find_mirrors(lines) do
    for {line, y_index} <- Enum.with_index(lines),
        {char, x_index} <- Enum.with_index(String.codepoints(line)),
        char != ".",
        into: %{},
        do: {{x_index, y_index}, char}
  end

  defp max_x_y(lines) do
    max_x =
      lines
      |> List.first()
      |> String.length()
      |> Kernel.-(1)

    max_y = Enum.count(lines) - 1

    {max_x, max_y}
  end

  def solve2(input) do
    input
    |> read_input()
    |> max_energized()
  end

  def max_energized({mirrors, {max_x, max_y}}) do
    horizontal_rays =
      for y <- 0..(max_y - 1), reduce: [] do
        acc ->
          acc = [{{0, y}, :east} | acc]
          [{{max_y - 1, y}, :west} | acc]
      end

    vertical_rays =
      for x <- 0..(max_x - 1), reduce: [] do
        acc ->
          acc = [{{x, 0}, :south} | acc]
          [{{x, max_x - 1}, :north} | acc]
      end

    (horizontal_rays ++ vertical_rays)
    |> Task.async_stream(
      fn {{x, y}, direction} ->
        next_step(
          {mirrors, {max_x, max_y}},
          MapSet.new([{{x, y}, direction}]),
          MapSet.new([{{x, y}, :direction}]),
          1
        )
      end,
      ordered: false
    )
    |> Stream.map(fn {:ok, num} -> num end)
    |> Enum.max()
  end
end
