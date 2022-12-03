require "minitest/autorun"

require_relative "rucksacks"

class RucksacksTest < Minitest::Test
  def test_that_rucksacks_sum_of_priorities_is_correct
    rucksacks = Rucksacks.from_data('input-test.txt')

    assert_equal 157, rucksacks.sum_of_priorities
  end

  def test_rucksack_common_item_type
    rucksack = Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp')
    assert_equal 'p', rucksack.common_item_type
  end

  def test_rucksack_common_item_type_priority
    rucksack = Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp')
    assert_equal 16, rucksack.common_item_type_priority
  end
end

