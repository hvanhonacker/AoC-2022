require_relative 'monkey'

class MonkeyCircus
  def self.parse(input_file)
    new File.read(input_file).split(/\n{2}/).map do |mnk_input|
      Monkey.parse(mnk_input)
    end
  end

  def initialize(monkeys)
    @monkeys = monkeys
  end

  attr_reader :monkeys

  # def round
  #   monkeys.each
  # end
end
