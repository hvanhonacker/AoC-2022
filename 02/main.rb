require './tournament'

tournament = Tournament.new_from_input('input.txt')

puts "Total score: #{tournament.total_score}"
