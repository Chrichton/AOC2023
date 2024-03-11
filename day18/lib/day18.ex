defmodule Day18 do
  defmodule Command do
    defstruct [:direction, :distance, :color_code]

    def new(direction, distance, color_code) do
      %Command{direction: direction, distance: distance, color_code: color_code}
    end
  end

  alias Day18.Command

  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    [direction, distance, color_code] = String.split(line, " ")

    distance = String.to_integer(distance)
    color_code = String.slice(color_code, 1, String.length(line) - 6)
    Command.new(direction, distance, color_code)
  end

  def solve(input) do
    trench =
      input
      |> read_input()
      |> Enum.reduce(
        {{0, 0}, MapSet.new([{0, 0}])},
        fn %Command{direction: direction, distance: distance}, {last_position, positions} ->
          {last_position, next_positions} = next_positions(last_position, direction, distance)
          {last_position, MapSet.union(positions, MapSet.new(next_positions))}
        end
      )
      |> elem(1)
      |> MapSet.to_list()

    trench_count = Enum.count(trench)

    interior_count =
      trench
      |> Enum.sort_by(fn {x, _y} -> x end)
      |> Enum.sort_by(fn {_x, y} -> y end)
      |> process_lines()
      |> Enum.sum()

    trench_count + interior_count
  end

  def process_lines(coords) do
    {_min_x, min_y} = hd(coords)
    {_max_x, max_y} = List.last(coords)

    Enum.map(min_y..max_y, fn current_y ->
      Enum.filter(coords, fn {_x, y} -> y == current_y end)
      |> Enum.map(fn {x, _y} -> x end)
    end)
    |> Enum.map(&strip_continuous_numbers/1)
    |> Enum.map(fn x_coords -> process_x_coords(x_coords) end)
  end

  def process_x_coords(x_coords) do
    IO.inspect(x_coords, label: "x_coords")

    pairs =
      Enum.chunk_every(x_coords, 2, 1, :discard)
      |> IO.inspect(label: "pairs")

    Enum.zip(pairs, 0..(Enum.count(pairs) - 1))
    |> Enum.filter(fn {_pair, index} -> rem(index, 2) == 0 end)
    |> Enum.map(fn {pair, _index} -> pair end)
    |> Enum.reduce(0, fn [from, to], acc -> to - from - 1 + acc end)
  end

  def strip_continuous_numbers([_first | rest] = numbers) do
    last_number = -1
    rest = rest ++ [last_number]

    numbers
    |> Enum.zip(rest)
    |> Enum.reduce({[], :from_right}, fn {number, next_number}, {acc, direction} ->
      case direction do
        :from_right ->
          if number + 1 == next_number,
            do: {acc, direction},
            else: {[number | acc], :from_left}

        :from_left ->
          if next_number == last_number do
            {[number | acc], :skip}
          else
            if number + 1 == next_number,
              do: {[number | acc], :skip},
              else: {acc, direction}
          end

        :skip ->
          if number + 1 == next_number,
            do: {acc, :skip},
            else: {acc, :from_left}
      end
    end)
    |> elem(0)
    |> Enum.reverse()
  end

  def next_positions(last_position, direction, distance) do
    case direction do
      "R" -> next_x_positions(last_position, distance, fn n, m -> n + m end)
      "L" -> next_x_positions(last_position, distance, fn n, m -> n - m end)
      "U" -> next_y_positions(last_position, distance, fn n, m -> n - m end)
      "D" -> next_y_positions(last_position, distance, fn n, m -> n + m end)
    end
  end

  defp next_x_positions({x_last, y_last}, distance, sum_func) do
    next_positions =
      Enum.reduce(1..distance, [], fn summand, acc ->
        [{sum_func.(x_last, summand), y_last} | acc]
      end)

    last_position = hd(next_positions)
    {last_position, next_positions}
  end

  defp next_y_positions({x_last, y_last}, distance, sum_func) do
    next_positions =
      Enum.reduce(1..distance, [], fn summand, acc ->
        [{x_last, sum_func.(y_last, summand)} | acc]
      end)

    last_position = hd(next_positions)
    {last_position, next_positions}
  end
end
