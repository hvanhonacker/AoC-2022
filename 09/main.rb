require 'matrix'

rope = Array.new(10) { Vector[0, 0] }
t_pos = [rope.last]

V = {
  "R" => Vector[1,0],
  "L" => Vector[-1,0],
  "U" => Vector[0,1],
  "D" => Vector[0,-1]
}

def move_ahead(cur, ahead)
  delta = ahead-cur
  delta[0] = delta[0] / delta[0].abs unless delta[0].zero?
  delta[1] = delta[1] / delta[1].abs unless delta[1].zero?

  cur + delta
end

def infinite_norm(v)
  [v[0].abs, v[1].abs].max
end

File.read('input.txt').split(/\n/).each do |move|
  dir, n = move.split(' ')

  n.to_i.times do
    moved_rope = []

    rope.each_with_index do |knot, i|
      if i == 0
        moved_rope << knot + V[dir]
      else
        ahead = moved_rope[i-1]
        moved_rope << (infinite_norm(ahead-knot) <= 1 ? knot : move_ahead(knot, ahead))
      end
    end

    rope = moved_rope

    t_pos << rope.last
  end
end

puts t_pos.uniq.size
# 2661
