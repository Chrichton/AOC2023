defmodule Day08Test do
  use ExUnit.Case

  test "read_input" do
    assert Day08.read_input("sample") |> elem(1) ==
             %{"AAA" => {"BBB", "BBB"}, "BBB" => {"AAA", "ZZZ"}, "ZZZ" => {"ZZZ", "ZZZ"}}
  end

  test "sample" do
    assert Day08.solve("sample") == 6
  end

  test "star" do
    assert Day08.solve("star") == 19783
  end
end
