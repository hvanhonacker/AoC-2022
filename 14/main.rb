require_relative "world"

puts "Test input:\n"
world = World.parse("input-test.txt")
world.play
puts world
puts "Sand grains: #{world.sand_grains_count}"

puts "\nActual input:\n"
world = World.parse("input.txt")
world.play
puts world
puts "Sand grains: #{world.sand_grains_count}"
