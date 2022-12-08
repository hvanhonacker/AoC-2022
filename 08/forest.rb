
class Forest
  attr_reader :forest, :tr_forest

  def initialize(input)
    @forest = input.map { _1.chars.map(&:to_i) }
    @tr_forest = @forest.transpose
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
