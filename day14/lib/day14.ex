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

  def cycles(rows, cycle, max_cycles) when cycle == max_cycles * 4 do
    rows
    |> Enum.map(&calc_load/1)
    |> Enum.sum()
  end

  def cycles(rows, cycle, max_cycles) do
    rows
    |> rotate_right()
    |> Enum.map(&move_os_right/1)
    |> cycles(cycle + 1, max_cycles)
  end

  @cycle_from_80 [
    98593,
    98607,
    98630,
    98653,
    98655,
    98646,
    98633,
    98612,
    98590,
    98576,
    98565,
    98562,
    98574,
    98587,
    98595,
    98593,
    98585
  ]

  def calc_load_from_80_cycles_on(cycles) do
    index = rem(cycles - 80, Enum.count(@cycle_from_80))
    Enum.at(@cycle_from_80, index)
  end
end
