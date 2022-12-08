require "minitest/autorun"
require "byebug"

require_relative 'forest'

class ForestTest < Minitest::Test
  def test_the_sum_of_visibile_trees
    input = <<~TXT
      30373
      25512
      65332
      33549
      35390
    TXT

    forest = Forest.new(input.split(/\n/))

    assert_equal 21, forest.visibility_score
  end

  def test_the_highest_scenic_score
    input = <<~TXT
      30373
      25512
      65332
      33549
      35390
    TXT

    forest = Forest.new(input.split(/\n/))

    assert_equal 8, forest.highest_scenic_score
  end

  def test_scenic_score_in_line
    forest = Forest.new([])

    assert_equal 2 * 2, forest.scenic_score_in_line(2, [3,3,5,4,9])
    assert_equal 2 * 1, forest.scenic_score_in_line(3, [3,5,3,5,3])
  end

  def test_scenic_score_ahead
    forest = Forest.new([])

    assert_equal 3, forest.scenic_score_ahead([3,2,2,3,1])
    assert_equal 1, forest.scenic_score_ahead([3,3,2,3,1])
    assert_equal 1, forest.scenic_score_ahead([3,4,2,3,1])
    assert_equal 1, forest.scenic_score_ahead([3,4,2,3,1])
  end

end
