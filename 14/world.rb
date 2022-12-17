require "matrix"

DEBUG = false

class World

  def self.parse(file)
    x_min, x_max = Float::INFINITY, -Float::INFINITY
    y_min, y_max = 0, 0
    rock_ranges = []

    File.read(file).split(/\n/).each do |rock|
      rock.split(' -> ').map { _1.split(',') }.map { |pos| pos.map(&:to_i) }.each_cons(2) do |s, e|

        # Determine the world limits
        x_min = [x_min, s[0], e[0]].min
        x_max = [x_max, s[0], e[0]].max
        y_min = [y_min, s[1], e[1]].min
        y_max = [y_max, s[1], e[1]].max

        # prepare rock ranges
        rock_ranges << [ Range.new(*[s[0], e[0]].sort), Range.new(*[s[1], e[1]].sort) ]
      end
    end

    new(x_min, x_max, y_min, y_max).tap do |world|
      rock_ranges.each do |xy_ranges|
        world.add_rocks(*xy_ranges)
      end
    end
  end

  FLOOR_Y_OFFSET = 2

  def initialize(x_min, x_max, y_min, y_max)
    @y_min = y_min
    @y_max = y_max + FLOOR_Y_OFFSET
    @x_min = SOURCE_POS[0] - (@y_max - @y_min)
    @x_max = SOURCE_POS[0] + (@y_max - @y_min)

    puts "Dimensions [#{x_min}-#{x_max} x #{y_min}-#{y_max}]"# if DEBUG

    @world = Array.new(@x_max + 1 - @x_min) { Array.new(@y_max + 1 - @y_min) }
    @sand_grains_count = 0

    # add_source
  end

  attr_reader :x_min, :x_max, :y_min, :y_max, :world, :sand_grains_count

  ROCK = :r
  SAND = :s
  SOURCE = :src
  SOURCE_POS = Vector[500, 0]

  def source
    SOURCE_POS
  end

  def free?(x, y)
    puts "#{x}, #{y} free?" if DEBUG

    return false if y >= y_max

    (!world[x - x_min][y - y_min]).tap do |res|
      puts res if DEBUG
    end
  end

  def add_source
    world[source[0] - x_min][source[1] - y_min] = SOURCE
  end

  def add_rocks(x_range, y_range)
    x_range.each do |x|
      y_range.each do |y|
        @world[x - x_min][y - y_min] = ROCK
      end
    end
  end

  def put_sand(x, y)
    @world[x - x_min][y - y_min] = SAND
  end

  def to_s
    world.transpose.map do |line|
      line.map do |c|
        case c
        when nil
          '.'
        when SAND
          'o'
        when ROCK
          '#'
        when SOURCE
          '+'
        end
      end.join
    end.join("\n")
  end

  def play
    sand = Sand.new(source, self)
    i = 1

    loop do
      while sand.move && sand.pos != source; end

      @sand_grains_count += 1

      put_sand(*sand.pos)

      break if sand.pos == source

      sand.move_to(source) # reset sand position

      yield(self, i) if block_given?

      i += 1
    end

    i
  end

  class Sand
    STRAIGHT_DOWN = Vector[  0, 1]
    LEFT_DOWN     = Vector[ -1, 1]
    RIGHT_DOWN    = Vector[  1, 1]

    MOVES = [STRAIGHT_DOWN, LEFT_DOWN, RIGHT_DOWN]

    def initialize(pos, world)
      @pos = pos
      @world = world
    end

    attr_reader :pos, :world

    def move
      MOVES
        .detect do |move|
          world.free?(*(new_pos = pos + move).to_a) && move_to(new_pos)
        end
    end

    def move_to(new_pos)
      @pos = new_pos

      true
    end
  end
end
