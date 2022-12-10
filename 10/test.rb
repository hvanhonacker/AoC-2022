require 'minitest/autorun'

require_relative "elves_cpu"

class TestElvesCpu < Minitest::Test

  def test_40th_cycles_values_checksum
    instr = File.read('input-test.txt').split(/\n/)
    checksum = ElvesCpu.new(instr).run.reg_values_checksum

    assert_equal 13140, checksum
  end

  def test_noop
    instr = [
      'noop'
    ]

    reg_vals = ElvesCpu.new(instr).run.reg_vals

    assert_equal [1, 1], reg_vals
  end

  def test_addX
    instr = [
      'addx -2',
      'noop'
    ]

    reg_vals = ElvesCpu.new(instr).run.reg_vals

    assert_equal [1, 1, 1, -1], reg_vals
  end

end
