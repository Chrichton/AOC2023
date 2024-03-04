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

  test "line_with_fixed_smudge1" do
    assert Day13.line_with_fixed_smudge(grid1(), [5]) == [3]
  end

  test "line_with_fixed_smudge2" do
    assert Day13.line_with_fixed_smudge(grid2(), [4]) == [1]
  end

  test "line_with_fixed_smudge1 transposed" do
    grid =
      grid1()
      |> Day13.transpose()

    assert Day13.line_with_fixed_smudge(grid, [5]) == []
  end

  test "line_with_fixed_smudge2 transposed" do
    grid =
      grid2()
      |> Day13.transpose()

    assert Day13.line_with_fixed_smudge(grid, [4]) == []
  end

  test "sample2" do
    assert Day13.solve2("sample") == 400
  end
end
