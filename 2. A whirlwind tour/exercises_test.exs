ExUnit.start
defmodule Chapter2.ExercisesTest do
  use ExUnit.Case, async: true
  import Chapter2.Exercises

  test "sum list of numbers" do
    assert sum([1,2,3]) == 6
  end

  test "transform  w/pipe [1,[[2],3]] to [9, 4, 1]" do
    assert transform_with_pipe([1,[[2],3]]) == [9, 4, 1]
  end

  test "transform  wout/pipe [1,[[2],3]] to [9, 4, 1]" do
    assert transform_without_pipe([1,[[2],3]]) == [9, 4, 1]
  end

  test "translate in md5 Tales from the Crypt" do
    assert translate("Tales from the Crypt") ==
      <<79, 132, 235, 77, 3, 224, 121, 88, 98, 75, 61, 67, 62, 16, 233, 91>>
  end

  test "ipv4 parser"
end
