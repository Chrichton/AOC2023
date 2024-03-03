defmodule Day13 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn row ->
      row
      |> String.split("\n", trim: true)
      |> Enum.map(&String.codepoints/1)
    end)
  end

  def solve(input) do
    input
    |> read_input()
    |> Enum.map(&process_grid/1)
    |> Enum.sum()
  end

  def process_grid(grid) do
    horizontal_line = perfect_reflections(grid)

    if horizontal_line == [] do
      [vertical_line] =
        grid
        |> transpose()
        |> perfect_reflections()

      vertical_line
    else
      hd(horizontal_line) * 100
    end
  end

  def perfect_reflections(grid) do
    max_y = Enum.count(grid) - 1

    0..(max_y - 1)
    |> Enum.reduce([], fn row_no, acc ->
      if mirror?(grid, row_no, max_y + 1),
        do: [row_no + 1 | acc],
        else: acc
    end)
  end

  def mirror?(grid, row_no, y_count) do
    {upper, lower} = split_beneath_row(grid, row_no, y_count)

    upper_count = Enum.count(upper)
    lower_count = Enum.count(lower)

    {upper, lower} =
      if upper_count <= lower_count do
        {upper, lower |> Enum.take(upper_count) |> Enum.reverse()}
      else
        {upper |> Enum.drop(upper_count - lower_count), lower |> Enum.reverse()}
      end

    upper == lower
  end

  def split_beneath_row(grid, row_no, y_count) do
    upper = Enum.take(grid, row_no + 1)

    lower =
      grid
      |> Enum.drop(row_no + 1)
      |> Enum.take(y_count)

    {upper, lower}
  end

  def transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
