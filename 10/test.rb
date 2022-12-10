require 'minitest/autorun'

require_relative "elves_cpu"

class TestElvesCPU < Minitest::Test

  def test_40th_cycles_values_checksum
    instr = File.read('input-test.txt').split(/\n/)
    checksum = ElvesCPU.new.run(instr).reg_values_checksum

    assert_equal 13140, checksum
  end

  def test_noop
    instr = [
      'noop'
    ]

    reg_vals = ElvesCPU.new.run(instr).reg_vals

    assert_equal [1, 1], reg_vals
  end

  def test_addX
    instr = [
      'addx -2',
      'noop'
    ]

    reg_vals = ElvesCPU.new.run(instr).reg_vals

    assert_equal [1, 1, 1, -1], reg_vals
  end

end
