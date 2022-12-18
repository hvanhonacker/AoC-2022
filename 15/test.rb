require "minitest/autorun"

require_relative "beacon_sensor"

class BeaconSensorTester < Minitest::Test
  def test_part_1
    assert_equal 26, BeaconSensor.parse("input-test.txt").solve(10)
  end

  def test_detects_unavailable_x_pos
    c1 = Circle.new(-1,3,-1,5)
    c2 = Circle.new(3,3,5,3)

    world = BeaconSensor.new([c1, c2])

    assert_equal 0, world.solve(0)
    assert_equal 2, world.solve(1)
    assert_equal 6, world.solve(2)
    assert_equal 6, world.solve(3)
    assert_equal 6, world.solve(4)
    assert_equal 1, world.solve(5)
    assert_equal 0, world.solve(6)
  end

  def test_part_2
    assert_equal 56000011, BeaconSensor.parse("input-test.txt").solve_part2(20)
  end

  def test_reduce_ranges
    # [---r1---]....[[---r2---]]
    assert_equal (0..1), BeaconSensor.reduce_ranges([(0..1)])
    assert_equal (0..2), BeaconSensor.reduce_ranges([(0..1), (1..2)])
    assert_equal (0..4), BeaconSensor.reduce_ranges([(0..1), (1..2), (3..4)])

    # assert_equal nil, BeaconSensor.reduce_ranges([(0..1), (3..4)])
    # assert_equal nil, BeaconSensor.reduce_ranges([(13..-9), (24..-6), (12..14), (22..2), (26..-6), (26..2), (6..10), (0..12), (8..-8), (26..14), (31..3), (18..14), (16..12), (14..20)])
  end

  def test_range_merge
    # [---r1---]....[[---r2---]]
    assert_equal nil, BeaconSensor.merge((0..1), (3..4))
    assert_equal nil, BeaconSensor.merge((3..4), (0..1))

    # [---r1---][[---r2---]]
    assert_equal (0..4), BeaconSensor.merge((0..1), (2..4))
    assert_equal (0..4), BeaconSensor.merge((2..4), (0..1))

    # [---r1--[[-]---r2---]]
    assert_equal (0..4), BeaconSensor.merge((0..3), (2..4))
    assert_equal (0..4), BeaconSensor.merge((2..4), (0..3))

    # [---r1--[[----r2---]]--]
    assert_equal (0..4), BeaconSensor.merge((0..4), (1..3))
    assert_equal (0..4), BeaconSensor.merge((1..3), (0..4))

    assert_equal (0..4), BeaconSensor.merge((1..-1), (0..4))
    assert_equal (0..4), BeaconSensor.merge((0..4), (1..-1))
  end
end
