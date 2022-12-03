require 'set'

class Rucksacks
  def self.from_data(data)
    rucksacks = File.read(data).split(/\n/)

    new(rucksacks.map { |rucksack_content| Rucksack.new(rucksack_content) })
  end

  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def sum_of_priorities
    @rucksacks.map(&:priority).sum
  end
end

class Rucksack

  attr_reader :content, :compartment_1, :compartment_2

  def initialize(content)
    @content = content

    @compartment_1 = content[0..content.size/2-1].split('')
    @compartment_2 = content[content.size/2..-1].split('')
  end

  def common_item_type_priority
    item_type_priority(common_item_type)
  end
  alias_method :priority, :common_item_type_priority

  def common_item_type
    Set.new(compartment_1.to_enum).intersection(Set.new(compartment_2.to_enum)).first
  end

  ITEM_TYPES = [('a'..'z'), ('A'..'Z')].map(&:to_a).join

  def item_type_priority(item_type)
    ITEM_TYPES.index(item_type) + 1
  end
end

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

