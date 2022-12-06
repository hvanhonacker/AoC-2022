require "minitest/autorun"

require_relative 'signal_stream'

class SignalStreamTest < Minitest::Test
  def test_that_start_of_packet_detection_is_correct
    res = SignalStream.new('bvwbjplbgvbhsrlpgdmjqwftvncz').chars_before_start_of_packet_detection
    assert_equal 5, res

    res = SignalStream.new('nppdvjthqldpwncqszvftbrmjlhg').chars_before_start_of_packet_detection
    assert_equal 6, res

    res = SignalStream.new('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg').chars_before_start_of_packet_detection
    assert_equal 10, res

    res = SignalStream.new('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw').chars_before_start_of_packet_detection
    assert_equal 11, res
  end
end

