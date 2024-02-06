defmodule Day09 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def solve(input) do
    input
    |> read_input()
    |> Enum.map(fn line -> add_next_line([line]) end)
    |> Enum.map(fn lines_list ->
      Enum.map(lines_list, fn lines -> List.last(lines) end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def add_next_line([line | _rest] = lines) do
    next_line =
      Enum.zip(Enum.take(line, Enum.count(line) - 1), Enum.drop(line, 1))
      |> Enum.reduce([], fn {top, bottom}, acc -> [bottom - top | acc] end)
      |> Enum.reverse()

    lines = [next_line | lines]

    if Enum.all?(next_line, &(&1 == 0)),
      do: Enum.reverse(lines),
      else: add_next_line(lines)
  end
end
