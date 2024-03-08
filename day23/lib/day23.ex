defmodule Day23 do
  defmodule Hike do
    @enforce_keys [:coord, :visited]
    defstruct [:coord, :visited]

    def new({x, y}, visited),
      do: %Hike{coord: {x, y}, visited: visited}
  end

  alias Day23.Hike

  def read_input(input) do
    lines =
      input
      |> File.read!()
      |> String.split("\n")

    max_y = Enum.count(lines) - 1
    max_x = lines |> Enum.at(0) |> String.length() |> Kernel.-(1)

    trails =
      for {line, y_index} <- Stream.with_index(lines),
          {char, x_index} <- Stream.with_index(String.codepoints(line)),
          char != "#",
          into: %{},
          do: {{x_index, y_index}, char}

    start_coord = {1, 0}
    dest_coord = {max_x - 1, max_y}

    {trails, start_coord, dest_coord, max_x, max_y}
  end

  def solve(input) do
    input
    |> read_input()
    |> then(fn {trails, start_coord, dest_coord, max_x, max_y} ->
      next_step(
        trails,
        max_x,
        max_y,
        [Hike.new(start_coord, MapSet.new([start_coord]))],
        [],
        dest_coord
      )
    end)
  end

  def next_step(trails, max_x, max_y, hikes, completed_hikes, dest_coord) do
    hikes
    |> Enum.reduce(
      {hikes, completed_hikes},
      fn hike, {acc_hikes, acc_completed_hikes} ->
        next_hikes =
          next_hikes(hike, trails, max_x, max_y)
      end
    )
    |> then(fn {new_hikes, new_visited} ->
      next_step(trails, max_x, max_y, new_hikes, completed_hikes, dest_coord)
    end)
  end

  def next_hikes(%Hike{} = hike, trails, max_x, max_y) do
    case trails.fetch(trails, hike.coord) do
      {:ok, ">"} -> [next_hike(hike, :east)]
      {:ok, "<"} -> [next_hike(hike, :west)]
      {:ok, "^"} -> [next_hike(hike, :north)]
      {:ok, "v"} -> [next_hike(hike, :south)]
      {:ok, "."} -> neighbors(hike)
    end
    |> Enum.filter(fn %Hike{coord: {x1, y1}} ->
      x1 in 0..max_x and y1 in 0..max_y
    end)
  end

  defp next_hike(%Hike{coord: {x, y}, visited: visited}, direction) do
    case direction do
      :north ->
        next_coord = {x, y - 1}
        Hike.new(next_coord, MapSet.put(visited, next_coord))

      :south ->
        next_coord = {x, y + 1}
        Hike.new(next_coord, MapSet.put(visited, next_coord))

      :west ->
        next_coord = {x + 1, y}
        Hike.new(next_coord, MapSet.put(visited, next_coord))

      :east ->
        next_coord = {x + 1, y}
        Hike.new(next_coord, MapSet.put(visited, next_coord))
    end
  end

  defp neighbors(%Hike{coord: {x, y}, visited: visited}) do
    [
      {x, y - 1},
      {x, y + 1},
      {x + 1, y},
      {x - 1, y}
    ]
    |> Enum.map(&Hike.new(&1, MapSet.put(visited, &1)))
  end
end
