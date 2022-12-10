require_relative "elves_cpu"

instr = File.read('input.txt').split(/\n/)
puts ElvesCpu.new(instr).run.reg_values_checksum
# 13520
