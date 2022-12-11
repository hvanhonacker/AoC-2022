
require_relative "monkey_circus"

p MonkeyCircus.parse('input.txt').play_rounds(20).monkey_business_level
# 50830

p MonkeyCircus.parse('input.txt').part_2.play_rounds(10_000).monkey_business_level
# 14399640002
