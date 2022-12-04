require "minitest/autorun"

require_relative 'assignment_checker'

class RucksacksTest < Minitest::Test
  def test_that_rucksacks_sum_of_priorities_is_correct
    res = AssignmentChecker.new('input-test.txt').full_overlaps_count
    assert_equal 2, res
  end
end

