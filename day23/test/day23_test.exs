defmodule Day23Test do
  use ExUnit.Case

  test "read_input" do
    {%{} = map, start_coord, dest_coord, max_x, max_y} = Day23.read_input("sample")

    assert Map.keys(map) |> Enum.count() > 0
    assert start_coord == {1, 0}
    assert dest_coord == {max_x - 1, max_y}
    assert max_x == String.length("#.#####################") - 1
    assert max_y == max_x
  end
end
