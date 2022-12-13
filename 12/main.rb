require_relative "signal_walker"
require 'byebug'

res = SignalWalker.parse('input.txt').min_path_size

puts res
