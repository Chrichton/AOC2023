defmodule Day10 do
  def read_input(input) do
    input =
      input
      |> File.read!()

    lines = String.split(input, "\n")
    y_range = 0..(Enum.count(lines) - 1)

    locations_chars_map =
      for {y_index, line} <- Enum.zip(y_range, lines),
          chars = String.codepoints(line),
          {x_index, char} <- Enum.zip(0..(Enum.count(chars) - 1), chars),
          char != ".",
          reduce: %{} do
        acc -> Map.put(acc, {x_index, y_index}, char)
      end

    [start_position] =
      locations_chars_map
      |> Map.filter(fn {_coord, char} -> char == "S" end)
      |> Map.keys()

    locations_pipes_map =
      locations_chars_map
      |> Map.reject(fn {_coord, char} -> char == "S" end)

    {start_position, locations_pipes_map}
  end
end
