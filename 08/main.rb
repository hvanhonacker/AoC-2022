require_relative 'forest'

p Forest.new(File.read('input.txt').split(/\n/)).visibility_score
# 1816

p Forest.new(File.read('input.txt').split(/\n/)).highest_scenic_score
# 383520
