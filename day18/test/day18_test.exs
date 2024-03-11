defmodule Day18Test do
  use ExUnit.Case

  test "read_input" do
    assert Day18.read_input("sample") == [
             %Day18.Command{color_code: "#70c710", direction: "R", distance: 6},
             %Day18.Command{color_code: "#0dc571", direction: "D", distance: 5},
             %Day18.Command{color_code: "#5713f0", direction: "L", distance: 2},
             %Day18.Command{color_code: "#d2c081", direction: "D", distance: 2},
             %Day18.Command{color_code: "#59c680", direction: "R", distance: 2},
             %Day18.Command{color_code: "#411b91", direction: "D", distance: 2},
             %Day18.Command{color_code: "#8ceee2", direction: "L", distance: 5},
             %Day18.Command{color_code: "#caa173", direction: "U", distance: 2},
             %Day18.Command{color_code: "#1b58a2", direction: "L", distance: 1},
             %Day18.Command{color_code: "#caa171", direction: "U", distance: 2},
             %Day18.Command{color_code: "#7807d2", direction: "R", distance: 2},
             %Day18.Command{color_code: "#a77fa3", direction: "U", distance: 3},
             %Day18.Command{color_code: "#015232", direction: "L", distance: 2},
             %Day18.Command{color_code: "#7a21e3", direction: "U", distance: 2}
           ]
  end

  test "process_x_coords" do
    # count numbers between pairs of neighbor-numbers
    assert Day18.process_x_coords([0, 2, 3, 7]) == 1 + 0 + 3
  end

  # test "process_x_coords three coords" do
  #   # count numbers between pairs of neighbor-numbers
  #   assert Day18.process_x_coords([1, 3, 7]) == 4
  # end

  test "process_x_coords two coords" do
    assert Day18.process_x_coords([0, 6]) == 5
  end

  test "process_x_coords one coords" do
    assert Day18.process_x_coords([6]) == 0
  end

  test "strip_continuous_numbers" do
    assert Day18.strip_continuous_numbers([0, 1, 3, 4, 5]) == [1, 3]
  end

  test "strip_continuous_numbers2" do
    assert Day18.strip_continuous_numbers([0, 1, 4, 5, 6]) == [1, 4]
  end

  test "strip_continuous_numbers3" do
    assert Day18.strip_continuous_numbers([0, 6]) == [0, 6]
  end

  test "sample" do
    assert Day18.solve("sample") == 62
  end

  # 68521, 52098 too high, 46847 too low
  test "star" do
    assert Day18.solve("star") == 0
  end
end
