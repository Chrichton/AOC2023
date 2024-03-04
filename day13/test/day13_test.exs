defmodule Day13Test do
  use ExUnit.Case

  def grid1() do
    [
      ["#", ".", "#", "#", ".", ".", "#", "#", "."],
      [".", ".", "#", ".", "#", "#", ".", "#", "."],
      ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
      ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
      [".", ".", "#", ".", "#", "#", ".", "#", "."],
      [".", ".", "#", "#", ".", ".", "#", "#", "."],
      ["#", ".", "#", ".", "#", "#", ".", "#", "."]
    ]
  end

  def grid2() do
    [
      ["#", ".", ".", ".", "#", "#", ".", ".", "#"],
      ["#", ".", ".", ".", ".", "#", ".", ".", "#"],
      [".", ".", "#", "#", ".", ".", "#", "#", "#"],
      ["#", "#", "#", "#", "#", ".", "#", "#", "."],
      ["#", "#", "#", "#", "#", ".", "#", "#", "."],
      [".", ".", "#", "#", ".", ".", "#", "#", "#"],
      ["#", ".", ".", ".", ".", "#", ".", ".", "#"]
    ]
  end

  test "read_input" do
    assert Day13.read_input("sample") ==
             [
               grid1(),
               grid2()
             ]
  end

  test "sample" do
    assert Day13.solve("sample") == 405
  end

  test "star" do
    assert Day13.solve("star") == 35360
  end

  test "lines_with_fixed_smudge1" do
    assert Day13.lines_with_fixed_smudge(grid1(), [5]) == [3]
  end

  test "line_with_fixed
  _smudge2" do
    assert Day13.lines_with_fixed_smudge(grid2(), [4]) == [1]
  end

  test "lines_with_fixed_smudge1 transposed" do
    assert Day13.lines_with_fixed_smudge(grid1() |> Day13.transpose(), [5]) == []
  end

  test "lines_with_fixed_smudge2 transposed" do
    assert Day13.lines_with_fixed_smudge(grid2() |> Day13.transpose(), [4]) == []
  end

  test "sample2" do
    assert Day13.solve2("sample") == 400
  end

  # 28173, 34107 too low
  test "star2" do
    assert Day13.solve2("star") == 36755
  end
end

# me
# 6, 0, 8, 7, 1, 0, 6, 4, 4, 0, 5, 0, 0, 9, 1100, 9, 1000, 1200, 8, 7, 1000, 200, 14, 14, 100, 1600, 8, 1100, 900, 0, 1, 300, 0, 0, 200, 9, 900, 1400, 0, 1300, 16, 10, 1200, 11, 800, 0, 11, 0, 1100, 900, ...]

# correct
# [6, 6, 8, 7, 1, 100, 6, 4, 4, 100, 5, 2, 4, 9, 1100, 9, 1000, 1200, 8, 7, 1000, 200, 14, 14, 100, 1600, 8, 1100, 900, 200, 1, 300, 4, 600, 200, 9, 900, 1400, 100, 1300, 16, 10, 1200, 11, 800, 4, 11, 400, 1100, 900, ...]
