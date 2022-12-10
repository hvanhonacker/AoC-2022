class ElvesCRT
  def initialize
    @cycle = 1
    @output = []
  end

  def plug(cpu)
    @cpu = cpu
    @cpu.plug(self)
    self
  end

  def tick
    px_pos = (cycle - 1) % LINE_CYCLE
    line = (cycle - 1) / LINE_CYCLE

    i = cpu.reg_val
    sprite_pos = (i-1..i+1)

    output[line] = [] if px_pos == 0
    output[line] << (sprite_pos.include?(px_pos) ? '#' : '.')

    @cycle += 1
  end

  def to_s
    output.map(&:join).join("\n")
  end

  private

  LINE_CYCLE = 40

  attr_reader :cpu, :cycle, :output
end
