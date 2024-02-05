defmodule Day07Test do
  use ExUnit.Case

  test "sample" do
    assert Day07.solve("sample") == 6440
  end

  test "star1" do
    assert Day07.solve("star") == 247_961_593
  end
end
