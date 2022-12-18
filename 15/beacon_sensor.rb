require_relative "circle"

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
end
