require "matrix"

class Circle
  def self.parse(line)
    new *line.scan(/Sensor at x=(\-?\d+), y=(\-?\d+): closest beacon is at x=(\-?\d+), y=(\-?\d+)/).first.map(&:to_i)
  end

  def initialize(xs, ys, xb, yb)
    @sensor_pos = Vector[xs, ys]
    @beacon_pos = Vector[xb, yb]

    @radius = manhattan_dist(@sensor_pos, @beacon_pos)
  end

  attr_reader :sensor_pos, :beacon_pos

  def intersect_y(y, x_min: -Float::INFINITY, x_max: Float::INFINITY)
    xs, ys = sensor_pos.to_a

    x_inf = xs - (radius - (ys - y).abs)
    x_sup = xs + (radius - (ys - y).abs)

    x_inf = [x_min, x_inf].max
    x_sup = [x_max, x_sup].min

    Range.new(*[x_inf, x_sup])
  end

  private

  attr_reader :radius

  def manhattan_dist(p1, p2)
    (p1 - p2).to_a.map(&:abs).sum
  end
end
