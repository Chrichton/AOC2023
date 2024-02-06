defmodule Day08Test do
  use ExUnit.Case

  # test "read_input" do
  #   assert Day08.read_input("sample") |> elem(1) ==
  #            %{"AAA" => {"BBB", "BBB"}, "BBB" => {"AAA", "ZZZ"}, "ZZZ" => {"ZZZ", "ZZZ"}}
  # end

  # test "sample" do
  #   assert Day08.solve("sample") == 6
  # end

  # test "star" do
  #   assert Day08.solve("star") == 19783
  # end

  # test "read_input2" do
  #   assert Day08.read_input2("star") |> Day08.convert() == %{
  #            "11A" => {"11B", "11B"},
  #            "11B" => {"11A", "11Z"},
  #            "11Z" => {"11Z", "22Z"}
  #          }
  # end

  # test "sample2" do
  #   assert Day08.solve2("sample") == 6
  # end

  @tag timeout: :infinity
  test "star2" do
    # too low
    assert Day08.solve2("star") == 19783
  end
end
