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
    |> Enum.map(&move_os_right/1)
    |> Enum.map(&calc_load/1)
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
    |> List.zip()
    |> Enum.map(fn line ->
      line
      |> Tuple.to_list()
      |> Enum.reverse()
    end)
  end
end
