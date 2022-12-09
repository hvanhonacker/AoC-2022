require 'matrix'

h = t = Vector[0, 0]
t_pos = [t]

V = {
  "R" => Vector[1,0],
  "L" => Vector[-1,0],
  "U" => Vector[0,1],
  "D" => Vector[0,-1]
}

def move_tail(tail, head)
  delta = head-tail
  delta[0] = delta[0] / delta[0].abs if delta[0] !=0
  delta[1] = delta[1] / delta[1].abs if delta[1] !=0

  tail + delta
end

def infinite_norm(v)
  [v[0].abs, v[1].abs].max
end

File.read('input.txt').split(/\n/).each do |move|
  dir, n = move.split(' ')

  n.to_i.times do
    h += V[dir]
    t = infinite_norm(h-t) <= 1 ? t : move_tail(t, h)
    t_pos << t
  end
end

puts t_pos.uniq.size
