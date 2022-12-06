
require_relative 'signal_stream'

input = File.read('input.txt')
puts SignalStream.new(input).chars_before_start_of_packet_detection
puts SignalStream.new(input).chars_before_start_of_message_detection
