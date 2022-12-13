require_relative "signal_walker"
require 'byebug'

puts SignalWalker.parse('input.txt').min_path_size
