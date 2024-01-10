defmodule Day01 do
  def solve1(filename) do
    filename
    |> read_input()
    |> Enum.map(&calc_calibration_value/1)
    |> Enum.sum()
  end

  def calc_calibration_value(string) do
    (find_first_digit(string) <> find_first_digit(String.reverse(string)))
    |> String.to_integer()
  end

  def find_first_digit(string) when is_binary(string) do
    string
    |> to_charlist()
    |> Enum.find(nil, fn x -> digit?(x) end)
    |> to_digit()
    |> Integer.to_string()
  end

  defp digit?(char), do: char in ?0..?9

  defp to_digit(char), do: char - ?0

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
