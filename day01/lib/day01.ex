defmodule Day01 do
  def solve1(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    filename
    |> File.read!()
  end
end
