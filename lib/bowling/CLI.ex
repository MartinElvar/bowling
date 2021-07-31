defmodule Bowling.CLI do
  @moduledoc """
  Prints and formats bowling match frames, using a comma seperated list of scores.

  Ex.
  `./bowling "0, 3, 5, 0, 9, 1, 2, 5, 3, 2, 4, 2, 3, 3, 4, 6, 10, 10, 2, 5" `
  """

  @spec main([binary, ...]) :: :ok
  def main(args) do
    args
    |> format()
  end

  defp format_score(score) when score == 0, do: "-"

  defp format_score(score), do: score

  defp format([frames_arg]) do
    1..10
    |> Enum.each(fn f ->
      IO.write("| f#{f} ")
    end)

    IO.puts("  |")

    frames_list =
      frames_arg
      |> String.split(", ")
      |> Enum.map(&String.to_integer/1)
      |> Bowling.parse_frames()

    Enum.each(frames_list, fn
      [_score_1] ->
        IO.write("|X   ")

      [score_1, score_2] when score_1 + score_2 == 10 ->
        IO.write("|#{format_score(score_1)}, /")

      [score_1, score_2] ->
        IO.write("|#{format_score(score_1)}, #{format_score(score_2)}")

      [_score_1, score_2, score_3] ->
        IO.write("|X, #{format_score(score_2)}, #{format_score(score_3)}")
    end)

    # Extra spacing depending on scores in last frame.
    last_frame = Enum.at(frames_list, 9)
    if Enum.count(last_frame) == 3 do
      IO.puts("|")
    else
      IO.puts("   |")
    end

    IO.puts("score: #{Bowling.calculate_total_score(frames_list)}")
  end
end
