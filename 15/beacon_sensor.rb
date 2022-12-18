require_relative "circle"
require 'set'

class BeaconSensor
  def self.parse(file_path)
    new File.read(file_path).split(/\n/).map { |l| Circle.parse(l) }
  end

  def initialize(circles)
    @circles = circles
  end

  attr_reader :circles

  def solve(y)
    known_positions = circles.map { |c| [c.sensor_pos, c.beacon_pos] }.flatten

    known_positions_xs = known_positions.keep_if { |p| p[1] == y }.map { |p| p[0] }.uniq

    circles.inject([]) { |res, circle| (res + circle.intersect_y(y).to_a).uniq }.then { |res| res - known_positions_xs }.then { _1 }.size
  end

  def solve_part2(size)
    res_y, res_range = (0..size).detect do |y|
      r = circles.map { |circle| circle.intersect_y(y, x_min: 0, x_max: size) }
                  .then { |ranges| self.class.reduce_ranges(ranges) }
                  .then { |range| range.size >= size + 1 ? false : range }

      break([y, r]) if r
    end

    res_x = res_range.begin == 0 ? res_range.end + 1 : res_range.begin - 1

    res_x * 4000000 + res_y
  end

  def self.reduce_ranges(ranges)
    ranges = ranges.reject { |r| r.size.zero? }

    while cur_range = ranges.pop
      #puts "#{cur_range} -> #{ranges.join ', '}"
      break unless ranges.detect.with_index { |r, i| merge(cur_range, r)&.tap { |new_range| ranges[i] = new_range } }
    end

    #puts "=> #{cur_range}"

    cur_range
  end

  def self.merge(r1, r2)
    if r1.begin <= r2.begin
      if r1.end < r2.begin - 1
        nil
      elsif r1.end >= r2.end
        r1
      elsif r1.end >= r2.begin - 1
        (r1.begin..r2.end)
      else
        raise "merge ? #{r1} #{r2}"
      end
    else
      merge(r2, r1)
    end
  end
end
