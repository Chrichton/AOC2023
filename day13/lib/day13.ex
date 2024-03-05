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
      grid
      |> transpose()
      |> perfect_reflections()
      |> hd()
    else
      hd(horizontal_line) * 100
    end
  end

  def perfect_reflections(grid) do
    max_y = Enum.count(grid) - 1

    result =
      0..(max_y - 1)
      |> Enum.reduce([], fn row_no, acc ->
        if mirror?(grid, row_no, max_y + 1),
          do: [row_no + 1 | acc],
          else: acc
      end)

    if result == [],
      do: [],
      else: [Enum.max(result)]
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
    perfect_line = perfect_line(grid)

    horizontal_line =
      grid
      |> lines_with_fixed_smudge(perfect_line)
      |> enum_max()
      |> Kernel.*(100)

    vertical_line =
      grid
      |> transpose()
      |> lines_with_fixed_smudge(perfect_line)
      |> enum_max()

    max(horizontal_line, vertical_line)

    #  perfect_line = perfect_line(grid)

    # if horizontal_line == [] do
    #   vertical_line = lines_with_fixed_smudge(transpose(grid), perfect_line)

    #   if vertical_line == [] do
    #     IO.inspect(grid, label: "grid")
    #     IO.inspect(perfect_line, label: "perfect_line")
    #     IO.puts("\n")

    #     0
    #   else
    #     Enum.max(vertical_line)
    #   end
    # else
    #   horizontal_line
    #   |> Enum.max()
    #   |> Kernel.*(100)
    # end
  end

  def perfect_line(grid) do
    horizontal_line = perfect_reflections(grid)

    if horizontal_line != [] do
      horizontal_line
    else
      grid
      |> transpose()
      |> perfect_reflections()
    end
  end

  def lines_with_fixed_smudge(grid, old_perfect_line) do
    for {line, y} <- Stream.with_index(grid),
        {char, x} <- Stream.with_index(line) do
      if char == "#",
        do: perfect_reflections(grid, x, y, ".", old_perfect_line),
        else: perfect_reflections(grid, x, y, "#", old_perfect_line)
    end
    |> Enum.reject(&(&1 == 0))
    |> Enum.uniq()
  end

  def perfect_reflections(grid, x, y, replace_char, old_perfect_line) do
    perfect_line =
      grid
      |> replace(x, y, replace_char)
      |> perfect_reflections()

    if perfect_line != [] and perfect_line != old_perfect_line,
      do: hd(perfect_line),
      else: 0
  end

  def replace(grid, x, y, to) do
    grid_line = Enum.at(grid, y)
    replaced_line = List.replace_at(grid_line, x, to)
    List.replace_at(grid, y, replaced_line)
  end

  def enum_max([]), do: 0
  def enum_max(list), do: Enum.max(list)
end
