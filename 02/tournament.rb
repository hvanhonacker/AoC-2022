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
      :loose => 0,
      :draw => 3,
      :win => 6,
    }

    MOVES_MAPPING = {
      'X' => :rock,
      'Y' => :paper,
      'Z' => :scissors,

      'A' => :rock,
      'B' => :paper,
      'C' => :scissors,
    }

    attr_reader :op_play, :our_play

    def initialize(op_play, our_play)
      @op_play  = MOVES_MAPPING[op_play]
      @our_play = MOVES_MAPPING[our_play]
    end

    def score
      MOVE_SCORE_VALUES[our_play] + RESULT_SCORES[result]
    end

    def result
      op_idx  = MOVES_HIERARCHY.index(op_play)
      our_idx = MOVES_HIERARCHY.index(our_play)

      if op_idx == our_idx
        :draw
      elsif ((our_idx - 1) % 3) == op_idx
        :win
      else
        :loose
      end
    end
  end
end

