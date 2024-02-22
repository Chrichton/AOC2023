defmodule Day15 do
  def solve(input) do
    input
    |> File.read!()
    |> String.split(",")
    |> Enum.map(&hash/1)
    |> Enum.sum()
  end

  def hash(string) do
    string
    |> String.to_charlist()
    |> Enum.reduce(0, fn ascii_code, acc ->
      ((ascii_code + acc) * 17)
      |> rem(256)
    end)
  end
end
