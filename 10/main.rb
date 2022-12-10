require_relative "elves_cpu"
require_relative "elves_crt"

instr = File.read('input.txt').split(/\n/)

# Part 1
puts ElvesCPU.new.run(instr).reg_values_checksum
# 13520

# Part 2
cpu = ElvesCPU.new
crt = ElvesCRT.new.plug(cpu)
cpu.run(instr)

puts crt
# .###...##..###..#..#.###..####..##..###.
# .#..#.#..#.#..#.#..#.#..#.#....#..#.#..#
# .#..#.#....#..#.####.###..###..#..#.###.
# .###..#.##.###..#..#.#..#.#....####.#..#
# .#....#..#.#....#..#.#..#.#....#..#.#..#
# .#.....###.#....#..#.###..####.#..#.###.

# PGPHBEAB
