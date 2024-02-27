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

  test "sample2" do
    assert Day08.solve2("sample") == 6
  end

  test "star2" do
    assert Day08.solve2("star") == 9_177_460_370_549
  end
end
