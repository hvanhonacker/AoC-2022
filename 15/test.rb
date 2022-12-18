require "minitest/autorun"

require_relative "beacon_sensor"

class BeaconSensorTester < Minitest::Test
  def test_detects_unavailable_x_pos
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
end
