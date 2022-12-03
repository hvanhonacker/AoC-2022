require_relative 'rucksacks'

rucksacks = Rucksacks.from_data('input.txt')

puts "Sum of priorities of the rucksacks: #{rucksacks.sum_of_priorities}"
