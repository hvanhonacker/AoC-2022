require "minitest/autorun"

require_relative "rucksacks"

class RucksacksTest < Minitest::Test
  def test_that_rucksacks_sum_of_priorities_is_correct
    rucksacks = Rucksacks.from_data('input-test.txt')

    assert_equal 70, rucksacks.sum_of_priorities
  end
end

