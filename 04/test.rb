require "minitest/autorun"

require_relative 'assignment_checker'

class AssignmentCheckerTest < Minitest::Test
  def test_that_full_overlaps_count_is_correct_for_test_data
    res = AssignmentChecker.from_data('input-test.txt').full_overlaps_count
    assert_equal 2, res
  end

  def test_that_overlaps_count_is_correct_for_test_data
    res = AssignmentChecker.from_data('input-test.txt').overlaps_count
    assert_equal 4, res
  end

  def test_that_overlaps_count_is_correct
    res = AssignmentChecker.new(["2-4,6-8"]).overlaps_count
    assert_equal 0, res

    res = AssignmentChecker.new(["2-3,4-5"]).overlaps_count
    assert_equal 0, res

    res = AssignmentChecker.new(["5-7,7-9"]).overlaps_count
    assert_equal 1, res

    res = AssignmentChecker.new(["2-8,3-7"]).overlaps_count
    assert_equal 1, res

    res = AssignmentChecker.new(["6-6,4-6"]).overlaps_count
    assert_equal 1, res

    res = AssignmentChecker.new(["2-6,4-8"]).overlaps_count
    assert_equal 1, res
  end
end

