input = File.read('input.txt').split(/\n/)

crates_map, moves = input.slice_when {_1 == ''}.to_a

crates_map = crates_map.map { |line|
  (0..8).map { |i|
    line[1+i*4]
  }
}.slice_before { _1[0] == '1' }.to_a[0]

res = []
(0..crates_map.first.size-1).each do |j|
  (crates_map.size-1).downto(0) do |i|
    res[j] ||= []
    res[j] << crates_map[i][j] if crates_map[i][j] != ' '
  end
end

crates_map = res

moves.each do |move|
  number, start, arrival = move.scan(/move (\d+) from (\d+) to (\d+)/).first.map(&:to_i)

  number.times do
    crates_map[arrival-1] << crates_map[start-1].pop
  end
end

puts crates_map.map{_1.last}.join ''

