defmodule Day07 do
  def read_input(input) do
    File.read!(input)
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, " ")
      [cards_str, bid_str] = String.split(line, " ")
      {String.codepoints(cards_str), String.to_integer(bid_str)}
    end)
  end

  def solve(input, star) do
    input
    |> read_input()
    |> sort_games(star)
    |> Enum.with_index(fn {_cards, bid, _sort_number}, index ->
      (index + 1) * bid
    end)
    |> Enum.sum()
  end

  def sort_games(games, star) do
    games
    |> Enum.map(fn {cards, bid} ->
      {cards, bid, sort_number({cards, frequencies(cards, star), card_ranks(star)})}
    end)
    |> Enum.sort_by(fn {_cards, _bid, sort_number} ->
      sort_number
    end)
  end

  def sort_number({cards, frequencies, card_ranks}) do
    initial_sort_number =
      frequencies
      |> game_strength()
      |> Kernel.*(100_000_000_000_000)

    Enum.zip([100_000_000_000, 100_000_000, 1_000_000, 10_000, 100], cards)
    |> Enum.reduce(initial_sort_number, fn {factor, card}, acc ->
      Map.get(card_ranks, card) * factor + acc
    end)
  end

  def card_ranks(:star1) do
    ranks = %{"A" => 14, "K" => 13, "Q" => 12, "J" => 11, "T" => 10}

    for number <- 2..9,
        reduce: ranks do
      acc -> Map.put(acc, Integer.to_string(number), number)
    end
  end

  def frequencies(cards, :star1) do
    cards
    |> Enum.frequencies()
    |> Map.to_list()
    |> Enum.map(fn {_card, count} -> count end)
    |> Enum.sort(:desc)
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

  # ---------------------------------------------------------

  def card_ranks(:star2) do
    ranks = %{"A" => 14, "K" => 13, "Q" => 12, "J" => 1, "T" => 10}

    for number <- 2..9,
        reduce: ranks do
      acc -> Map.put(acc, Integer.to_string(number), number)
    end
  end

  def frequencies(cards, :star2) do
    joker_count = Enum.count(cards, &(&1 == "J"))

    if joker_count == 5,
      do: [5],
      else: calc_frequencies(cards, joker_count)
  end

  def calc_frequencies(cards, joker_count) do
    sorted_card_counts_without_joker =
      cards
      |> Enum.reject(&(&1 == "J"))
      |> Enum.frequencies()
      |> Map.to_list()
      |> Enum.map(fn {_card, count} -> count end)
      |> Enum.sort(:desc)

    if Enum.count(sorted_card_counts_without_joker) == 1 do
      [count] = sorted_card_counts_without_joker
      [count + joker_count]
    else
      [max | rest] = sorted_card_counts_without_joker
      [max + joker_count | rest]
    end
  end
end
