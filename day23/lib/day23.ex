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

    {trails, start_coord, dest_coord}
  end

  def solve(input) do
    input
    |> read_input()
    |> then(fn {trails, start_coord, dest_coord} ->
      next_step(
        trails,
        [Hike.new(start_coord, MapSet.new([start_coord]))],
        [],
        dest_coord,
        1
      )
    end)
  end

  def next_step(_trails, [], completed_hikes, _dest_coord, _count) do
    Stream.map(completed_hikes, fn %Hike{visited: visited} -> visited end)
    # |> Stream.map(&Enum.count/1)
    # |> Enum.max()
    # |> Kernel.-(1)
  end

  def next_step(trails, hikes, completed_hikes, dest_coord, count) do
    hikes
    |> Enum.reduce(
      {[], completed_hikes},
      fn hike, {acc_hikes, acc_completed_hikes} ->
        next_hikes(hike, trails)
        |> Enum.reduce(
          {acc_hikes, acc_completed_hikes},
          fn %Hike{coord: coord} = hike, {acc_hikes2, acc_completed_hikes2} ->
            if coord == dest_coord,
              do: {acc_hikes2, [hike | acc_completed_hikes2]},
              else: {[hike | acc_hikes2], acc_completed_hikes2}
          end
        )
      end
    )
    |> then(fn {new_hikes, new_completed_hike} ->
      # IO.inspect({new_hikes, new_completed_hike}, label: "new_hikes")

      next_step(trails, new_hikes, new_completed_hike, dest_coord, count + 1)
    end)
  end

  def next_hikes(%Hike{} = hike, trails) do
    case Map.fetch(trails, hike.coord) do
      {:ok, ">"} -> [next_hike(hike, :east)]
      {:ok, "<"} -> [next_hike(hike, :west)]
      {:ok, "^"} -> [next_hike(hike, :north)]
      {:ok, "v"} -> [next_hike(hike, :south)]
      {:ok, "."} -> neighbors(hike)
    end
    |> Enum.filter(fn %Hike{coord: coord, visited: visited} ->
      Map.fetch(trails, coord) != :error and
        not MapSet.member?(visited, coord)
    end)
    |> Enum.map(fn %Hike{coord: coord, visited: visited} = hike ->
      %{hike | visited: MapSet.put(visited, coord)}
    end)
  end

  defp next_hike(%Hike{coord: {x, y}} = hike, direction) do
    case direction do
      :north -> %{hike | coord: {x, y - 1}}
      :south -> %{hike | coord: {x, y + 1}}
      :west -> %{hike | coord: {x + 1, y}}
      :east -> %{hike | coord: {x + 1, y}}
    end
  end

  defp neighbors(%Hike{coord: {x, y}} = hike) do
    [
      {x, y - 1},
      {x, y + 1},
      {x + 1, y},
      {x - 1, y}
    ]
    |> Enum.map(&%{hike | coord: &1})
  end
end
