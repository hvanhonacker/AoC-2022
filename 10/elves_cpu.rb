class ElvesCPU

  def initialize
    @devices = []
  end

  attr_reader :reg_vals, :reg_val

  def run(instructions)
    @reg_val = 1
    @reg_vals = [@reg_val]

    instructions.each do |inst|
      case inst
      when /noop/
        noop
      when /addx (?<val>-?\d+)/
        addx($~[:val].to_i)
      else
        raise "Oups! #{instructions}"
      end
    end

    self
  end

  def reg_values_checksum
    (0..5).map do |n|
      cycle = 20 + n * 40
      reg_vals[cycle] * cycle
    end.sum
  end

  def addx(x)
    2.times { tick }

    @reg_val += x
  end

  def noop
    tick
  end

  def plug(device)
    @devices << device
  end

  def tick
    @reg_vals << @reg_val

    @devices.each(&:tick)
  end
end
