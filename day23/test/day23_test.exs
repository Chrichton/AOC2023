defmodule Day23Test do
  use ExUnit.Case

  alias Day23.Hike

  test "read_input" do
    {%{} = trails, start_coord, dest_coord} = Day23.read_input("sample")

    assert Map.keys(trails) |> Enum.count() > 0
    assert start_coord == {1, 0}
    assert dest_coord == {21, 22}
  end

  test "next_hikes start_coord" do
    {trails, {x, y} = start_coord, _dest_coord} = Day23.read_input("sample")
    hike = Hike.new(start_coord, MapSet.new([start_coord]))

    assert Day23.next_hikes(hike, trails) ==
             [Hike.new({x, y + 1}, MapSet.new([start_coord, {x, y + 1}]))]
  end

  test "sample" do
    assert Day23.solve("sample") == 94
  end

  test "star" do
    assert Day23.solve("star") == 2298
  end
end
