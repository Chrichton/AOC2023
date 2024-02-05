defmodule Day07 do
  def read_input(input) do
    File.read!(input)
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, " ")
      [hand_str, bid_str] = String.split(line, " ")
      {String.codepoints(hand_str), String.to_integer(bid_str)}
    end)
  end

  def solve(input) do
    input
    |> read_input()
    |> Enum.map(fn {hand, bid} ->
      {
        hand,
        hand
        |> Enum.frequencies()
        |> Map.to_list()
        |> Enum.map(fn {_card, count} -> count end)
        |> Enum.sort(:desc),
        bid
      }
    end)
    |> sort_games()
    |> Enum.with_index(fn {_cards_with_count, bid, _sort_number}, index ->
      (index + 1) * bid
    end)
    |> Enum.sum()
  end

  def sort_games(games) do
    games
    |> Enum.map(fn {cards, frequencies, bid} ->
      {cards, bid, sort_number({cards, frequencies})}
    end)
    |> Enum.sort_by(fn {_cards, _bid, sort_number} ->
      sort_number
    end)
  end

  def sort_number({cards, frequencies}) do
    initial_sort_number =
      frequencies
      |> game_strength()
      |> Kernel.*(100_000_000_000_000)

    Enum.zip([100_000_000_000, 100_000_000, 1_000_000, 10_000, 100], cards)
    |> Enum.reduce(initial_sort_number, fn {factor, card}, acc ->
      Map.get(card_ranks(), card) * factor + acc
    end)
  end

  def card_ranks do
    ranks = %{"A" => 14, "K" => 13, "Q" => 12, "J" => 11, "T" => 10}

    for number <- 2..9,
        reduce: ranks do
      acc -> Map.put(acc, Integer.to_string(number), number)
    end
  end

  def game_strength(frequencies) do
    case frequencies do
      [5] -> 7
      [4, 1] -> 6
      [3, 2] -> 5
      [3, 1, 1] -> 4
      [2, 2, 1] -> 3
      [2, 1, 1, 1] -> 2
      [1, 1, 1, 1, 1] -> 1
    end
  end
end
