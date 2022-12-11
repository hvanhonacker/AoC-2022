require_relative 'monkey'

class MonkeyCircus
  def self.parse(input_file)
    new(File.read(input_file).split(/\n{2}/).map do |mnk_input|
      Monkey.parse(mnk_input)
    end)
  end

  def initialize(monkeys)
    @monkeys = monkeys
  end

  attr_reader :monkeys

  def monkey_business_level
    monkeys.map(&:inspected_items_count).max(2).reduce(:*)
  end

  def play_rounds(n = 1)
    tap { n.times { round } }
  end

  def round
    tap do
      monkeys.each do |monkey|
        monkey.round do |item, other_monkey_idx|
          monkeys[other_monkey_idx].caaatch(item)
        end
      end
    end
  end

end
