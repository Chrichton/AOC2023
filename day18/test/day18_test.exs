defmodule Day18Test do
  use ExUnit.Case

  test "read_input" do
    assert Day18.read_input("sample") == [
             %Day18.Command{color_code: "#70c710", direction: "R", distance: "6"},
             %Day18.Command{color_code: "#0dc571", direction: "D", distance: "5"},
             %Day18.Command{color_code: "#5713f0", direction: "L", distance: "2"},
             %Day18.Command{color_code: "#d2c081", direction: "D", distance: "2"},
             %Day18.Command{color_code: "#59c680", direction: "R", distance: "2"},
             %Day18.Command{color_code: "#411b91", direction: "D", distance: "2"},
             %Day18.Command{color_code: "#8ceee2", direction: "L", distance: "5"},
             %Day18.Command{color_code: "#caa173", direction: "U", distance: "2"},
             %Day18.Command{color_code: "#1b58a2", direction: "L", distance: "1"},
             %Day18.Command{color_code: "#caa171", direction: "U", distance: "2"},
             %Day18.Command{color_code: "#7807d2", direction: "R", distance: "2"},
             %Day18.Command{color_code: "#a77fa3", direction: "U", distance: "3"},
             %Day18.Command{color_code: "#015232", direction: "L", distance: "2"},
             %Day18.Command{color_code: "#7a21e3", direction: "U", distance: "2"}
           ]
  end

  test "sample" do
    assert Day18.solve("sample") == nil
  end
end
