defmodule CLITest do
  use ExUnit.Case
  doctest Bowling

  import ExUnit.CaptureIO


  @match_frames "0, 3, 5, 0, 9, 1, 2, 5, 3, 2, 4, 2, 3, 3, 4, 6, 10, 10, 2, 5"


  test "args/1" do
    expected_output = """
    | f1 | f2 | f3 | f4 | f5 | f6 | f7 | f8 | f9 | f10   |
    |-, 3|5, -|9, /|2, 5|3, 2|4, 2|3, 3|4, /|X   |X, 2, 5|
    score: 103
    """

    assert capture_io(fn -> Bowling.CLI.main([@match_frames]) end) == expected_output
  end
end
