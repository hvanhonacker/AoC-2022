
require "json"
require "byebug"

require_relative "signal_checker"

pairs = File.read('input.txt').split(/\n{2}/).map { |pairs| pairs.split(/\n/).map { JSON.parse(_1) } }

puts checksum(pairs)

packets = File.read('input.txt').split(/\n/).reject { _1 == ""}.map { JSON.parse(_1) }
packets << [[2]]
packets << [[6]]
packets = packets.sort { |p1, p2| check(p1, p2) ? -1 : 1 }

puts (packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)
