
class Forest
  attr_reader :forest, :tr_forest

  def initialize(input)
    @forest = input.map { _1.chars.map(&:to_i) }
    @tr_forest = @forest.transpose
  end

  def highest_scenic_score
    scenic_score_map.flatten.max
  end

  def scenic_score_map
    forest.map.with_index do |trees_line,i|
      trees_line.map.with_index do |_,j|
        scenic_score(i, j)
      end
    end
  end

  def visibility_score
    visibility_map.flatten.select {_1}.size
  end

  def visibility_map
    forest.map.with_index do |trees_line,i|
      trees_line.map.with_index do |_,j|
        tree_visible?(i, j)
      end
    end
  end

  def scenic_score(i, j)
    scenic_score_in_line(i, forest[j]) * scenic_score_in_line(j, tr_forest[i])
  end

  def scenic_score_in_line(i, line)
    return 0 if i == 0 || i == (line.size - 1)

    looking_left = line[0..i].reverse
    looking_right = line[i..-1]

    scenic_score_ahead(looking_left) * scenic_score_ahead(looking_right)
  end

  def scenic_score_ahead(line)
    i = 1

    while(i < (line.size - 1) && line[0] > line[i])
      i += 1
    end

    i
  end

  def tree_visible?(i, j)
    tree_visible_in_line?(i,    forest[j]) ||
    tree_visible_in_line?(j, tr_forest[i])
  end

  def tree_visible_in_line?(i, line)
    return true if i == 0 || i == (line.size - 1)

    line[0..(i-1) ].none? { |h| h >= line[i] } ||
    line[(i+1)..-1].none? { |h| h >= line[i] }
  end
end
