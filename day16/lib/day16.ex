defmodule Day16 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> find_mirrors()
  end

  def find_mirrors(lines) do
    for {line, y_index} <- Enum.with_index(lines),
        {char, x_index} <- Enum.with_index(String.codepoints(line)),
        char != ".",
        into: %{},
        do: {{x_index, y_index}, char}
  end
end
