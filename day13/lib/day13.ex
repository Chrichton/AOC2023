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

  # ----------------------------------------------------------------

  def solve2(input) do
    input
    |> read_input()
    |> Enum.map(&process_grid2/1)
    |> Enum.sum()
  end

  def process_grid2(grid) do
    horizontal_line = perfect_reflections(grid)

    if horizontal_line == [] do
      grid = transpose(grid)

      [vertical_line] =
        grid
        |> perfect_reflections()

      line_with_fixed_snudge(grid, vertical_line)
      |> IO.inspect(label: "line_with_fixed_snudge(grid, vertical_line)")
      |> hd()
    else
      line_with_fixed_snudge(grid, horizontal_line)
      |> IO.inspect(label: "line_with_fixed_snudge(grid, horizontal_line)")
      |> hd()
      |> Kernel.*(100)
    end
  end

  def line_with_fixed_snudge(grid, old_perfect_line) do
    max_x =
      grid
      |> Enum.at(0)
      |> Enum.count()
      |> Kernel.-(1)

    max_y = Enum.count(grid) - 1

    Enum.zip(grid, 0..max_y)
    |> Enum.reduce_while([], fn {row, y}, acc ->
      Enum.zip(row, 0..max_x)
      |> Enum.reduce_while(acc, fn {char, x}, acc2 ->
        if char == "#",
          do: perfect_reflections(grid, x, y, ".", old_perfect_line, acc2),
          else: perfect_reflections(grid, x, y, "#", old_perfect_line, acc2)
      end)
    end)

    # Enum.with_index(grid, fn row, y ->
    #   Enum.zip(row, 0..max_x)
    #   |> Enum.reduce_while([], fn {char, x}, acc ->
    #     if char == "#",
    #       do: perfect_reflections(grid, x, y, ".", old_perfect_line, acc),
    #       else: perfect_reflections(grid, x, y, "#", old_perfect_line, acc)
    #   end)
    # end)

    # for {line, y} <- Stream.with_index(grid),
    #     {char, x} <- Stream.with_index(line) do
    #   if char == "#",
    #     do: perfect_reflections(grid, x, y, ".", old_perfect_line, []),
    #     else: perfect_reflections(grid, x, y, "#", old_perfect_line, [])
    # end
    # |> Enum.reject(&(&1 == {:cont, []}))
  end

  def perfect_reflections(grid, x, y, replace_char, old_perfect_line, acc) do
    perfect_line =
      grid
      |> replace(x, y, replace_char)
      |> perfect_reflections()

    if perfect_line != [] and perfect_line != old_perfect_line,
      do: {:halt, {:halt, perfect_line}},
      else: {:cont, {:cont, acc}}
  end

  def replace(grid, x, y, to) do
    grid_line = Enum.at(grid, y)
    replaced_line = List.replace_at(grid_line, x, to)
    List.replace_at(grid, y, replaced_line)
  end
end
