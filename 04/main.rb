require_relative 'assignment_checker'

part_1_res = AssignmentChecker.from_data('input.txt').full_overlaps_count
puts "Full overlaps count: #{part_1_res}"

part_2_res = AssignmentChecker.from_data('input.txt').overlaps_count
puts "Overlaps count: #{part_2_res}"
