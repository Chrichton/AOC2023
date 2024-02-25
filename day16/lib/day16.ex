defmodule Day16 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> find_mirrors()
  end

  def find_mirrors(lines) do
    for {line, y_index} <- Enum.with_index(lines),
        chars = String.codepoints(line),
        x_index_max = Enum.count(chars) - 1,
        {char, x_index} <- Enum.zip(chars, 0..x_index_max),
        char != ".",
        into: %{},
        do: {{x_index, y_index}, char}
  end
end
