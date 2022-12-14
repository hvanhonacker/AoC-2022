def checksum(pairs)
  pairs.map.with_index {|pair, i| check(*pair) ? i + 1 : nil }.compact.sum
end

def check(left, right)
  rec_check(left, right) == :OK
end

def rec_check(left, right)
  case [left, right]
  in[nil, _]
    :OK
  in [_, nil]
    :NOK
  in [Integer, Integer]
    if left < right
      :OK
    elsif left > right
      :NOK
    else
      nil
    end
  in [Integer, Array]
    rec_check(Array(left), right)
  in [Array, Integer]
    rec_check(left, Array(right))
  in [Array, Array]
    padding = Array.new([right.size - left.size, 0].max)
    (left + padding).zip(right).detect { |l, r| res = rec_check(l, r); break res if res }
  end
end
