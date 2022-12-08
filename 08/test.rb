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

  def test_the_sum_of_visibile_trees
    input = <<~TXT
      11
      11
    TXT

    forest = Forest.new(input.split(/\n/))

    assert_equal 4, forest.visibility_score
  end

  def test_the_sum_of_visibile_trees
    input = <<~TXT
      1
    TXT

    forest = Forest.new(input.split(/\n/))

    assert_equal 1, forest.visibility_score
  end

  def test_tree_visible_in_line
    forest = Forest.new([])

    assert_equal true, forest.tree_visible_in_line?(0, [0,1,0])
    assert_equal true, forest.tree_visible_in_line?(1, [0,1,0])
    assert_equal true, forest.tree_visible_in_line?(2, [0,1,0])

    assert_equal true, forest.tree_visible_in_line?(1, [2,1,0])
    assert_equal true, forest.tree_visible_in_line?(1, [0,1,2])

    assert_equal false, forest.tree_visible_in_line?(1, [1,0,1])
  end
end
