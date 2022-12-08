require_relative 'forest'

p Forest.new(File.read('input.txt').split(/\n/)).visibility_score
# 1816
