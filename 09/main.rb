require 'matrix'

DIR_VECT = {
  "R" => Vector[ 1,  0],
  "L" => Vector[-1,  0],
  "U" => Vector[ 0,  1],
  "D" => Vector[ 0, -1]
}

def knot_move(v)
  Vector[v[0].zero? ? v[0] : v[0] / v[0].abs,
         v[1].zero? ? v[1] : v[1] / v[1].abs]
end

def inf_norm(v)
  [v[0].abs, v[1].abs].max
end

rope = Array.new(10) { Vector[0, 0] }
t_pos = [rope.last]

File.read('input.txt').split(/\n/).each do |move|
  dir, n = move.split(' ')

  n.to_i.times do
    moved_rope = []

    rope.each_with_index do |knot, i|
      moved_rope <<
        if i == 0
          knot + DIR_VECT[dir]
        elsif inf_norm(delta = moved_rope[i-1] - knot) > 1
          knot + knot_move(delta)
        else
          knot
        end
    end

    rope = moved_rope

    t_pos << rope.last
  end
end

puts t_pos.uniq.size
# 2661
