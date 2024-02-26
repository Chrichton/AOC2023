defmodule Day16 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> find_mirrors()
  end

  def next_rays({{_x, _y} = position, direction} = ray, mirrors) do
    case Map.fetch(mirrors, position) do
      :error ->
        [next_ray(ray)]

      {:ok, "-"} ->
        if direction in [:west, :east] do
          [next_ray(ray)]
        else
          [next_ray({position, :north}), next_ray({position, :south})]
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
            [next_ray({position, :east})]

          :north ->
            [next_ray({position, :west})]
        end

      {:ok, "\\"} ->
        case direction do
          :east ->
            [next_ray({position, :south})]

          :west ->
            [next_ray({position, :north})]

          :south ->
            [next_ray({position, :west})]

          :north ->
            [next_ray({position, :east})]
        end
    end
    |> Enum.reject(fn {{x1, y1}, _direction} -> x1 < 0 or y1 < 0 end)
  end

  def next_ray({{x, y}, direction} = _ray) do
    cond do
      direction == :north -> {{x, y - 1}, :north}
      direction == :south -> {{x, y + 1}, :south}
      direction == :west -> {{x - 1, y}, :west}
      direction == :east -> {{x + 1, y}, :east}
    end
  end

  def find_mirrors(lines) do
    for {line, y_index} <- Enum.with_index(lines),
        {char, x_index} <- Enum.with_index(String.codepoints(line)),
        char != ".",
        into: %{},
        do: {{x_index, y_index}, char}
  end
end
