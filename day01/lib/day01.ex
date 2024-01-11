defmodule Day01 do
  def solve1(filename) do
    filename
    |> read_input()
    |> Enum.map(&calc_calibration_value1/1)
    |> Enum.sum()
  end

  def calc_calibration_value1(string) do
    (find_first_digit1(string) <> find_first_digit1(String.reverse(string)))
    |> String.to_integer()
  end

  def find_first_digit1(string) when is_binary(string) do
    string
    |> to_charlist()
    |> Enum.find(nil, fn x -> digit?(x) end)
    |> to_digit()
    |> Integer.to_string()
  end

  defp digit?(char), do: char in ?0..?9

  defp to_digit(char), do: char - ?0

  # Second star ----------------------------------------------------------------------

  @numbers %{
    "zero" => "0",
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9",
    "0" => "0",
    "1" => "1",
    "2" => "2",
    "3" => "3",
    "4" => "4",
    "5" => "5",
    "6" => "6",
    "7" => "7",
    "8" => "8",
    "9" => "9"
  }

  @reverse_numbers Map.new(@numbers, fn {key, value} -> {String.reverse(key), value} end)

  def solve2(filename) do
    filename
    |> read_input()
    |> Enum.map(&calc_calibration_value/1)
    |> Enum.sum()
  end

  def calc_calibration_value(string) do
    (find_first_digit(string, false) <> find_first_digit(string, true))
    |> String.to_integer()
  end

  def find_first_digit(string, reverse?) do
    numbers =
      if reverse?,
        do: @reverse_numbers,
        else: @numbers

    string =
      if reverse?,
        do: String.reverse(string),
        else: string

    numbers
    |> Map.keys()
    |> Enum.reduce([], fn number_string, acc ->
      case :binary.match(string, number_string) do
        :nomatch -> acc
        {index, _lenght} -> [{index, Map.get(numbers, number_string)} | acc]
      end
    end)
    |> Enum.min_by(fn {index, _number_string} -> index end)
    |> elem(1)
  end

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
