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

  def part_2
    dividers_product = monkeys.map(&:divider).reduce(:*)
    @worry_mod = ->(item) { item % dividers_product }

    self
  end

  attr_reader :monkeys, :worry_mod

  def monkey_business_level
    monkeys.map(&:inspected_items_count).max(2).reduce(:*)
  end

  def play_rounds(n = 1)
    n.times { round }

    self
  end

  def round
    monkeys.each do |monkey|
      monkey.round(worry_mod: worry_mod) do |item, other_monkey_idx|
        monkeys[other_monkey_idx].caaatch(item)
      end
    end

    self
  end
end
