defmodule Bowling do
  @moduledoc """
  Bowling allows for transforming strings of bowlings scores into list.
  It can also use the generated lists to calculate the total score of the frames.
  """

  @doc """
    Converts a lists of scores, to a list of frames.
  """

  @spec parse_frames(list) :: list
  def parse_frames(entries) do
    Enum.reduce(entries, [], fn entry, acc ->
      construct_frame(acc, entry)
    end)
    |> Enum.reverse()
  end

  # This is the first run, open new frame.
  defp construct_frame([], score), do: [[score]]

  # This is the last frame.
  defp construct_frame([last_frame | rem_frames] = frames, score) when length(frames) == 10 do
    [last_frame ++ [score] | rem_frames]
  end

  defp construct_frame([last_frame | rem_frames] = frames, score) do
    case last_frame do
      # If the last frame contains a strike, we close it, and open a new frame.
      [10] ->
        [[score] | frames]

      # If the last frame only contain one entry, we add this as the second entry.
      [first_score] ->
        [[first_score, score] | rem_frames]

      # If both first and second is preset in the last frame. We open a new frame.
      [_first_score, _second_score] ->
        [[score] | frames]
    end
  end

  @doc """
    Calculates a total, based of list containing frames.
  """

  @spec calculate_total_score([[number, ...]]) :: any
  def calculate_total_score(frames), do: get_frame_score(0, frames, nil)

  # All frames has been calculated, return total score.
  @spec get_frame_score(integer, [[number, ...]], nil | :spare | :strike) :: integer
  defp get_frame_score(total_score, [], nil), do: total_score

  # When a frame only contains one score.
  defp get_frame_score(total_score, [[score] | rem_frames], modifier) do
    new_total_score =
      case modifier do
        :spare ->
          total_score + 10 + score

        :strike ->
          total_score + 10 + score

        nil ->
          total_score + score
      end

    get_frame_score(new_total_score, rem_frames, :strike)
  end

  # When a frame contains 2 scores.
  defp get_frame_score(total_score, [[score_1, score_2] | rem_frames], modifier) do
    sum = score_1 + score_2

    new_total_score =
      case modifier do
        :spare ->
          total_score + score_1 + sum

        :strike ->
          total_score + sum + sum

        nil ->
          total_score + sum
      end

    new_modifier = if sum == 10, do: :spare

    get_frame_score(new_total_score, rem_frames, new_modifier)
  end

  # When a frame contains 3 scores.
  defp get_frame_score(total_score, [[score_1, score_2, score_3]], modifier) do
    sum = score_1 + score_2 + score_3

    new_total_score =
      case modifier do
        :spare ->
          total_score + score_1 + sum

        :strike ->
          total_score + score_1 + score_2 + sum

        nil ->
          total_score + score_1 + score_2 + score_3
      end

    get_frame_score(new_total_score, [], nil)
  end
end
