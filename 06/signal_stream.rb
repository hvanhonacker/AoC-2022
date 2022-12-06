require 'set'

class SignalStream
  def initialize(stream)
    @stream = stream
  end

  attr_reader :stream

  def chars_before_start_of_packet_detection
    start_of_packet_position + 1
  end

  def start_of_packet_position
    i = 3
    while Set.new(stream[(i-3)..i].chars).size < 4
      i += 1
    end
    i
  end
end
