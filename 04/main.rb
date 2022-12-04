require_relative 'assignment_checker'

part_1_res = AssignmentChecker.new('input.txt').full_overlaps_count
puts "Full overlaps count: #{part_1_res}"
