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

  def test_that_start_of_message_detection_is_correct
    res = SignalStream.new('mjqjpqmgbljsphdztnvjfqwrcgsmlb').chars_before_start_of_message_detection
    assert_equal 19, res

    res = SignalStream.new('bvwbjplbgvbhsrlpgdmjqwftvncz').chars_before_start_of_message_detection
    assert_equal 23, res

    res = SignalStream.new('nppdvjthqldpwncqszvftbrmjlhg').chars_before_start_of_message_detection
    assert_equal 23, res

    res = SignalStream.new('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg').chars_before_start_of_message_detection
    assert_equal 29, res

    res = SignalStream.new('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw').chars_before_start_of_message_detection
    assert_equal 26, res
  end
end

