defmodule BowlingTest do
  use ExUnit.Case
  doctest Bowling

  @match_frames [
    "0, 3, 5, 0, 9, 1, 2, 5, 3, 2, 4, 2, 3, 3, 4, 6, 10, 10, 2, 5",
    "7, 1, 5, 5, 2, 7, 4, 6, 0, 5, 8, 2, 8, 1, 4, 3, 2, 4, 5, 2"
  ]

  test "parse_frames/1" do
    expected_results = [
      [[0, 3], [5, 0], [9, 1], [2, 5], [3, 2], [4, 2], [3, 3], [4, 6], [10], [10, 2, 5]],
      [[7, 1], [5, 5], [2, 7], [4, 6], [0, 5], [8, 2], [8, 1], [4, 3],[ 2, 4], [5, 2]]
    ]

    @match_frames
    |> Enum.with_index
    |> Enum.each(fn({frames, i}) ->
      scores =
        frames
        |> String.split(", ")
        |> Enum.map(&String.to_integer/1)

      parsed_frames = Bowling.parse_frames(scores)
      expected_frames = Enum.at(expected_results, i)

      assert parsed_frames == expected_frames
    end)
  end

  test "calculate_total_score/1" do
    expected_results = [
      103, 91
    ]

    @match_frames
    |> Enum.with_index
    |> Enum.each(fn({frames, i}) ->
      scores =
        frames
        |> String.split(", ")
        |> Enum.map(&String.to_integer/1)

      parsed_frames = Bowling.parse_frames(scores)
      calculated_score = Bowling.calculate_total_score(parsed_frames)
      expected_total = Enum.at(expected_results, i)

      assert calculated_score == expected_total
    end)
  end
end
