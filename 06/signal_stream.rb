require 'set'

class SignalStream
  def initialize(stream)
    @stream = stream
  end

  attr_reader :stream

  def chars_before_start_of_packet_detection
    first_position_for_a_set_of_n_distinct_symbols(4) + 1
  end

  def chars_before_start_of_message_detection
    first_position_for_a_set_of_n_distinct_symbols(14) + 1
  end

  def first_position_for_a_set_of_n_distinct_symbols(n)
    i = n - 1
    while Set.new(stream[(i-(n-1))..i].chars).size < n
      i += 1
    end
    i
  end
end
