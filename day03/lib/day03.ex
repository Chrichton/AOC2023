# See AOC2021 day9.ex, day11.ex

defmodule Day03 do
  def solve(filename) do
    filename
    |> read_input()
  end

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Enum.with_index(fn line, _y_index ->
      line_chars = String.codepoints(line)
      look_ahead_chars = Enum.drop(line_chars, 1) ++ "."

      line_chars
      |> zip3(0..(String.length(line) - 1) |> Enum.to_list(), look_ahead_chars)
      |> Enum.reduce(
        {%{}, MapSet.new()},
        fn {char, x_index, look_ahead_char}, {number_strings_map, symbols_mapset} ->
          {number_strings_map, symbols_mapset}
        end
      )
    end)
  end

  def zip3([], _, _), do: []
  def zip3([x | xs], [y | ys], [z | zs]), do: [{x, y, z} | zip3(xs, ys, zs)]
end
