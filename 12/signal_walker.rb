require 'matrix'

class SignalWalker

  def self.parse(file)
    new(File.read(file).split(/\n/).map{|line| line.chars })
  end

  def initialize(map)
    @map = map
    @unvisited = []
    @visited_map = Array.new(map.size) { Array.new(map.first.size) { false }}
    @tentative_map = Array.new(map.size) { Array.new(map.first.size) { Float::INFINITY }}
  end

  attr_reader :map, :unvisited, :tentative_map, :visited_map

  def explore
    start = locate(START)

    update_tentative_value(start, 0)

    rec_explore(start)
  end

  def rec_explore(current)
    dump

    unvisited_neighbours(current).each do |neighbour|
      add_unvisited(neighbour)
      update_tentative_value(neighbour, tentative_value(current) + 1)
    end

    visited!(current)

    if(val(current) == DESTINATION)
      dump
      tentative_value(current)
    elsif unvisited.empty?
      nil
    else
      current = unvisited.sort_by { |node| tentative_value(node) }.first

      rec_explore(current)
    end
  end



  def unvisited_neighbours(node)
    neighbours(node)
      .reject { |o| visited?(o) }
      .keep_if { |o| reachable?(node, o) }
  end

  def add_unvisited(node)
    @unvisited << node
  end

  def visited!(node)
    visited_map[node[0]][node[1]] = true

    unvisited.delete(node)
  end

  def visited?(node)
    visited_map[node[0]][node[1]]
  end

  def update_tentative_value(node, new_value)
    current_value = tentative_map[node[0]][node[1]]
    tentative_map[node[0]][node[1]] = [current_value, new_value].min
  end

  def tentative_value(node)
    tentative_map[node[0]][node[1]]
  end

  def min_path_size
    explore
  end

  START = 'S'
  DESTINATION = 'E'

  def reachable?(from_point, to_point)
    from_val = CHAR_VALUES[val(from_point)]
    to_val = CHAR_VALUES[val(to_point)]

    from_val >= to_val - 1
  end

  CHAR_VALUES = ('a'..'z').to_a.zip(0..25).to_h.merge({ START => -1, DESTINATION => 26 })

  def val(point)
    map[point[0]][point[1]]
  end

  def neighbours(point)
    [].tap do |res|
      res << point + UP
      res << point + DOWN
      res << point + LEFT
      res << point + RIGHT
    end.keep_if do |v|
      v[0] >= 0 && v[0] < map.size &&
      v[1] >= 0 && v[1] < map.first.size
    end
  end

  def locate(char)
    map.each_with_index do |line, i|
      line.each_with_index do |el, j|
        return Vector[i, j] if el == char
      end
    end

    nil
  end

  UP = Vector[1, 0]
  DOWN = Vector[-1, 0]
  LEFT = Vector[0, -1]
  RIGHT = Vector[0, 1]

  def dump
    puts ""

    tentative_map.each do |line|
      puts line.map { |v|
        if v == Float::INFINITY
          "."
        else
          "x"
        end
      }.join
    end
  end

  # def dump
  #   puts ""

  #   tentative_map.each do |line|
  #     puts line.map { |v|
  #       if v == Float::INFINITY
  #         "..."
  #       elsif v < 10
  #         "  #{v}"
  #       elsif v < 100
  #         " #{v}"
  #       else
  #         v
  #       end
  #     }.join ' '
  #   end
  # end

end
