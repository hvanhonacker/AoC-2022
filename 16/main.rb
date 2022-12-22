require_relative "pressure_optimizer"

optimizer = PressureOptimizer.parse("input.txt")
optimizer.optimal_release(max_valves_count: 8)
# AA, EA, QN, GW, KB, NA, XX, UD, YD
# 1775
# ruby main.rb  701,94s user 4,21s system 99% cpu 11:46,66 total
