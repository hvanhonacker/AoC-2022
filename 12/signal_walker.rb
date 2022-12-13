require 'matrix'

class SignalWalker

  def self.parse(file)
    new(File.read(file).split(/\n/).map{|line| line.chars })
  end

  def initialize(map)
    @map = map
  end

  attr_reader :map, :xp_map

  def min_path_size
    min_path.size
  end

  def min_path
    res = paths.sort_by(&:size).first
    puts res.map { val(_1) }.join
    res
  end

  def paths
    rec_paths_to_obj(locate(START))
  end

  START = 'S'
  OBJ = 'E'

  # TODO: arrêter d'explorer si chemin plus long que le max déjà trouvé

  def rec_paths_to_obj(cur_point, cur_path: [])
    cur_path += [cur_point] unless val(cur_point) == START

    # puts "exploring #{cur_path.join(' / ')}…"

    success_paths = []

    if val(cur_point) == OBJ
      # p cur_path.map {|p| val(p) }.join
      [cur_path]
    else
      neighbours(cur_point)
        .reject { |o_point| cur_path.include? o_point }
        .keep_if { |o_point| reachable? cur_point, o_point }
        .each do |o_point|
          children_success_paths = rec_paths_to_obj(o_point, cur_path: cur_path)

          success_paths += children_success_paths
        end

      success_paths
    end
  end

  def reachable?(from_point, to_point)
    from_val = CHAR_VALUES[val(from_point)]
    to_val = CHAR_VALUES[val(to_point)]

    from_val >= to_val - 1
  end

  CHAR_VALUES = ('a'..'z').to_a.zip(0..25).to_h.merge({ START => -1, OBJ => 26 })

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

end
