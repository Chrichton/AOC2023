defmodule Day24 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [position, velocity] =
        String.split(line, " @ ")

      [string_to_coordinates(position) | [string_to_coordinates(velocity)]]
    end)
  end

  def string_to_coordinates(string) do
    string
    |> String.split(", ")
    |> Enum.map(fn s ->
      String.trim(s)
      |> String.to_integer()
    end)
    |> List.to_tuple()
  end

  def solve(input, {box_min, box_max}) do
    input
    |> read_input()
    |> Combination.combine(2)
    |> Enum.map(fn pair ->
      find_intersection_point(pair)
    end)
    |> Enum.filter(fn {key, _value} -> key == :fine end)
    |> Enum.map(fn {_key, value} -> value end)
    |> Enum.filter(fn {x, y} -> in_box?({x, y}, {box_min, box_max}) end)
    |> Enum.count()
  end

  def in_box?({x, y}, {min, max}),
    do: x >= min and x <= max and y >= min and y <= max

  def find_intersection_point([[{x0, y0, _z0}, {u0, v0, _w0}], [{x1, y1, _z1}, {u1, v1, _w1}]]) do
    if u0 * v1 - u1 * v0 == 0 do
      {:parallel, nil}
    else
      t = ((x1 - x0) * v1 - (y1 - y0) * u1) / (u0 * v1 - v0 * u1)
      s = ((x1 - x0) * v0 - (y1 - y0) * u0) / (u0 * v1 - v0 * u1)

      cond do
        t < 0 or s < 0 -> {:past, nil}
        true -> {:fine, {x0 + t * u0, y0 + t * v0}}
      end
    end
  end

  # def find_intersection_point([[{u0, v0, _w0}, {u1, v1, z1}], [{x0, y0, _z0}, {x1, y1, z1}]]) do
  #   if u0 * v1 - u1 * v0 == 0 do
  #     {:parallel, nil}
  #   else
  #     t = ((x1 - x0) * v1 - (y1 - y0) * u1) / (u0 * v1 - v0 * u1)
  #     s = ((x1 - x0) * v0 - (y1 - y0) * u0) / (u0 * v1 - v0 * u1)

  #     cond do
  #       t < 0 or s < 0 -> {:past, nil}
  #       true -> {:fine, {x0 + t * u0, y0 + t * v0}}
  #     end
  #   end
  # end

  # def find_intersection_point(
  #       {v1x, v1y} = _v1,
  #       {v2x, v2y} = _v2,
  #       {p1x, p1y} = _p1,
  #       {p2x, p2y} = _p2
  #     ) do
  #   # a = Nx.tensor([[v1x, -v2x], [v1y, -v2y]]) |> IO.inspect(label: "a")
  #   # b = Nx.tensor([[p2x - p1x], [p2y - p1y]]) |> IO.inspect(label: "b")
  #   # Nx.LinAlg.solve(a, b)

  #   #   a = det(v1, v2)
  #   #   b = det({x2 - x1, v1}, {y2 - y1, v1})
  #   #   if a != 0 do
  #   #     x = b / a
  #   #     y = det({x2 - x1, v1}, {x2 - x1, v2}) / a
  #   #     {x, y}
  #   #   else
  #   #     {:error, "Lines are parallel"}
  #   #   end
  #   # end

  #   _x = ((p2x - p1x) * -v2y + -v2x * (p2y - p1y)) / (v1x * -v2y + v2x * v1y)
  # end

  # defp det({a, b}, {c, d}), do: a * d - b * c
end
