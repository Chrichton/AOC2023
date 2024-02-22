defmodule Day15 do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split(",")
  end

  def solve(input) do
    input
    |> read_input()
    |> Enum.map(&hash/1)
    |> Enum.sum()
  end

  def hash(string) do
    string
    |> String.to_charlist()
    |> Enum.reduce(0, fn ascii_code, acc ->
      ((ascii_code + acc) * 17)
      |> rem(256)
    end)
  end

  def solve2(input) do
    input
    |> read_input()
    |> Enum.reduce(%{}, fn step, boxes_map ->
      case operation(step) do
        "=" ->
          put_lens_into_box(focal_lenghts(step), label(step), box_no(step), boxes_map)

        "-" ->
          remove_lens(label(step), box_no(step), boxes_map)
      end
    end)
    |> Map.reject(fn {_box_no, lenses} -> lenses == [] end)
    |> Map.to_list()
    |> Enum.flat_map(fn {box_no, lenses} ->
      Enum.with_index(lenses, fn {_label, focal_lenght}, index ->
        (box_no + 1) * (index + 1) * focal_lenght
      end)
    end)
    |> Enum.sum()
  end

  def put_lens_into_box(focal_length, lens_label, box_no, boxes_map) do
    Map.update(
      boxes_map,
      box_no,
      [{lens_label, focal_length}],
      fn lenses ->
        case Enum.find_index(
               lenses,
               fn {label, _fl} -> lens_label == label end
             ) do
          nil -> lenses ++ [{lens_label, focal_length}]
          lens_index -> List.replace_at(lenses, lens_index, {lens_label, focal_length})
        end
      end
    )
  end

  def remove_lens(lens_label, box_no, boxes_map) do
    Map.update!(boxes_map, box_no, fn lenses ->
      List.keydelete(lenses, lens_label, 0)
    end)
  end

  def box_no(step), do: step |> label() |> hash()
  def label(string), do: String.slice(string, 0, 2)
  def operation(string), do: String.at(string, 2)

  def focal_lenghts(string),
    do:
      string
      |> String.at(3)
      |> String.to_integer()
end
