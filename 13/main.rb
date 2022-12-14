
require "json"
require "byebug"

require_relative "signal_checker"

pairs = File.read('input.txt').split(/\n{2}/).map { |pairs| pairs.split(/\n/).map { JSON.parse(_1) } }

puts checksum(pairs)
# NOT 3326
