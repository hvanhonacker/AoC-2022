input = File.read("input.txt").split(/\n/)
  .inject([0]) do |res, val|
    if val == ""
      res << 0
    else
      res[-1] += val.to_i
    end

    res
  end

puts "day 1 part 1:"
puts input.max

puts "day 1 part 2:"
puts input.sort[-3..-1].sum
