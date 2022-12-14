DEBUG = true

def checksum(pairs)
  pairs.map.with_index {|pair, i| puts "\n== Pair #{i + 1} ==" if DEBUG; check(*pair) ? i + 1 : nil }.compact.sum
end

def check (left, right)
  rec_check(left, right) == :OK
end

def rec_check(left, right, idt = "")
  puts "#{idt}- Compare #{left} vs #{right}" if DEBUG

  case [left, right]
  in[nil,_]
    puts "#{idt}- Left side ran out of items, so inputs are in the right order"
    :OK
  in [_, nil]
    puts "#{idt}- Right side ran out of items, so inputs are not in the right order" if DEBUG
    :NOK
  in [Integer => l, Integer => r]
    if l < r
      puts "#{idt}  - Left side is smaller, so inputs are in the right order" if DEBUG
      :OK
    elsif l > r
      puts "#{idt}  - Right side is smaller, so inputs are not in the right order" if DEBUG
      :NOK
    else
      nil # continue
    end
  in [Integer => l, Array => r]
    puts "#{idt}  - Mixed types; convert left to [#{l}] and retry comparison" if DEBUG
    rec_check(Array(l), r, idt + "  ")
  in [Array => l, Integer => r]
    puts "#{idt}  - Mixed types; convert right to [#{r}] and retry comparison" if DEBUG
    rec_check(l, Array(r), idt + "  ")
  in [Array => l, Array => r]
    l << nil while l.size < r.size
    l.zip(r).detect { |lft, rgt| res = rec_check(lft, rgt, idt + "  "); break res if res }
  end
end
