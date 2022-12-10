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

  LINE_CYCLE = 40

  def tick
    i = @cpu.reg_val

    sprite_pos = (i-1..i+1)

    px_pos = (@cycle - 1) % LINE_CYCLE
    line = (@cycle - 1) / LINE_CYCLE

    #puts "#cycl: #{@cycle} - line: #{line} - px: #{px_pos}"

    @output[line] = [] if px_pos == 0
    @output[line][@cycle%40] = sprite_pos.include?(px_pos) ? '#' : '.'

    @cycle += 1
  end

  def to_s
    @output.map(&:join).join("\n")
  end
end
