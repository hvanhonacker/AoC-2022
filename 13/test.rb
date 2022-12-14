require "minitest/autorun"
require "json"
require "byebug"

require_relative "signal_checker"

class SignalCheckerTest < Minitest::Test
  def test_sort
    input = <<~TEXT
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
    TEXT

    packets = input.split(/\n/).reject { _1 == ""}.map { JSON.parse(_1) }
    packets << [[2]]
    packets << [[6]]
    packets = packets.sort { |p1, p2| check(p1, p2) ? -1 : 1 }

    assert_equal 140, (packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)
  end

  def test_checksum
    input = <<~TEXT
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
    TEXT

    pairs = input.split(/\n{2}/).map { |pairs| pairs.split(/\n/).map { JSON.parse(_1) } }

    assert_equal 13, checksum(pairs)
  end

  def test_pair_1
    assert check([1,1,3,1,1], [1,1,5,1,1])
  end

  def test_pair_2
    assert check([[1],[2,3,4]], [[1],4])
    refute check([[1],4], [[1],[2,3,4]])
  end

  def test_pair_3
    refute check([9], [[8,7,6]])
  end

  def test_pair_4
    assert check([[4,4],4,4], [[4,4],4,4,4])
  end

  def test_pair_5
    refute check([7,7,7,7], [7,7,7])
  end

  def test_pair_6
    assert check([], [3])
  end

  def test_pair_7
    refute check([[[]]], [[]])
  end

  def test_pair_8
    refute check([1,[2,[3,[4,[5,6,7]]]],8,9], [1,[2,[3,[4,[5,6,0]]]],8,9])
  end
end
