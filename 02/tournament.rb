require "byebug"

class Tournament
  def self.new_from_input(input_file)
    rounds = File.read(input_file).split(/\n/).map { _1.split ' '}

    new(rounds)
  end

  attr_reader :rounds
  def initialize(rounds)
    @rounds = rounds.map { |round| Round.new(*round) }
  end

  def total_score
    rounds.map(&:score).reduce(:+)
  end

  class Round
    MOVE_SCORE_VALUES = {
      :rock => 1,
      :paper => 2,
      :scissors => 3
    }

    MOVES_HIERARCHY = MOVE_SCORE_VALUES.keys

    RESULT_SCORES = {
      :lose => 0,
      :draw => 3,
      :win => 6,
    }

    OUTCOMES_MAPPING = {
      'X' => :lose,
      'Y' => :draw,
      'Z' => :win,
    }

    MOVES_MAPPING = {
      'A' => :rock,
      'B' => :paper,
      'C' => :scissors,
    }

    attr_reader :op_play, :result

    def initialize(enc_op_play, enc_result)
      @op_play = MOVES_MAPPING[enc_op_play]
      @result = OUTCOMES_MAPPING[enc_result]
    end

    def score
      MOVE_SCORE_VALUES[our_play] + RESULT_SCORES[result]
    end

    def our_play
      op_idx  = MOVES_HIERARCHY.index(op_play)

      case result
      when :draw
        op_play
      when :win
        MOVES_HIERARCHY[(op_idx + 1) % 3]
      when :lose
        MOVES_HIERARCHY[(op_idx - 1) % 3]
      end
    end
  end
end

