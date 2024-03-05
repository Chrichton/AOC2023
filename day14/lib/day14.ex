defmodule Day14 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
  end

  def solve(input) do
    input
    |> read_input()
    |> rotate_right()
    |> Stream.map(&move_os_right/1)
    |> Stream.map(&calc_load/1)
    |> Enum.sum()
  end

  def move_os_right(line) do
    line
    |> Enum.chunk_by(&(&1 == "#"))
    |> Enum.map(&Enum.sort/1)
    |> List.flatten()
  end

  def calc_load(line) do
    line
    |> Enum.zip(1..Enum.count(line))
    |> Enum.reduce(0, fn {char, weight}, acc ->
      if char == "O",
        do: acc + weight,
        else: acc
    end)
  end

  # transpose - reverse
  def rotate_right(rows) do
    rows
    |> Enum.zip()
    |> Enum.map(fn line ->
      line
      |> Tuple.to_list()
      |> Enum.reverse()
    end)
  end

  def solve2(input, max_cycles) do
    input
    |> read_input()
    |> cycles(0, max_cycles)
  end

  def cycles(rows, cycle, max_cycles) when cycle == max_cycles do
    rows
    |> rotate_right()
    |> Enum.map(&calc_load/1)
    |> Enum.sum()
  end

  def cycles(rows, cycle, max_cycles) do
    rows
    |> rotate_right()
    |> Enum.map(&move_os_right/1)
    |> rotate_right()
    |> Enum.map(&move_os_right/1)
    |> rotate_right()
    |> Enum.map(&move_os_right/1)
    |> rotate_right()
    |> Enum.map(&move_os_right/1)
    |> cycles(cycle + 1, max_cycles)
  end

  @cycle_from_81 [
    100_011,
    100_025,
    100_043,
    100_071,
    100_084,
    100_084,
    100_086,
    100_084,
    100_086,
    100_086,
    100_079,
    100_064,
    100_047,
    100_034,
    100_024,
    100_016,
    100_008
  ]

  def calc_load_from_81_cycles_on(cycles) do
    index = rem(cycles - 81, Enum.count(@cycle_from_81))
    Enum.at(@cycle_from_81, index)
  end
end
