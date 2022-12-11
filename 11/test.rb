require "minitest/autorun"

require_relative "monkey_circus"
require_relative "monkey"

class TestMonkeyCircus < MiniTest::Test
  def test_monkey_business_level
    assert_equal 10605, MonkeyCircus.parse('input-test.txt').play_rounds(20).monkey_business_level
  end

  def test_monkey_circus_parsing
    circus = MonkeyCircus.parse('input-test.txt')

    assert_equal 4, circus.monkeys.size
  end

  def test_monkey_round
    mnk_input = <<~TEXT
      Monkey 0:
      Starting items: 79
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3
    TEXT

    mnk = Monkey.parse(mnk_input).round do |item, target_mnk|
      assert_equal 500, item
      assert_equal 3, target_mnk
    end

    assert_empty mnk.items
  end

  def test_monkey_inspected_items_count
    mnk_input = <<~TEXT
      Monkey 0:
      Starting items: 1, 2, 3, 4
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3
    TEXT

    assert_equal 4, Monkey.parse(mnk_input).round.inspected_items_count
  end

  def test_monkey_parsing
    mnk_input = <<~TEXT
      Monkey 1:
      Starting items: 66, 52, 59, 79, 94, 73
      Operation: new = old + 1
      Test: divisible by 19
        If true: throw to monkey 4
        If false: throw to monkey 6
    TEXT

    mnk = Monkey.parse mnk_input

    assert_equal 1, mnk.id
    assert_equal [66, 52, 59, 79, 94, 73], mnk.items
    assert_equal 2 + 1, mnk.op.call(2)
    assert_equal false, mnk.test.call(20)
    assert_equal true, mnk.test.call(19)
    assert_equal 4, mnk.test_true
    assert_equal 6, mnk.test_false
  end
end
