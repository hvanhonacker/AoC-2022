require "minitest/autorun"
require "byebug"

require_relative "signal_walker"

class TestSignalWalker < Minitest::Test
  def test_min_path_test_data
    #assert_equal 31, SignalWalker.parse("input-test.txt").min_path.size
  end

  def test_min_path_test_data
    assert_equal 31, SignalWalker.parse("input-test.txt").min_path_size
  end

  def test_neighbours
    sw = SignalWalker.parse("input-test.txt")

    assert_equal 2, sw.neighbours(Vector[0, 0]).size
    assert_equal 3, sw.neighbours(Vector[0, 1]).size
    assert_equal 4, sw.neighbours(Vector[1, 1]).size

    assert_equal 2, sw.neighbours(Vector[4, 7]).size
    assert_equal 3, sw.neighbours(Vector[4, 6]).size
    assert_equal 4, sw.neighbours(Vector[3, 6]).size
  end
end
