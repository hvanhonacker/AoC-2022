
class AssignmentChecker

  def self.from_data(input_file)
    new(File.read(input_file).split(/\n/))
  end

  def initialize(assignment_pairs)
    @assignment_pairs = assignment_pairs
  end

  attr_reader :assignment_pairs

  def full_overlaps_count
    assignment_pairs.select do |pair|
      range_1, range_2 = pair.split(',').map{_1.split("-").map(&:to_i)}

      fully_overlaps? range_1, range_2
    end.size
  end

  def fully_overlaps?(range_1, range_2)
    range_1[0] >= range_2[0] && range_1[1] <= range_2[1] ||
    range_2[0] >= range_1[0] && range_2[1] <= range_1[1]
  end

  def overlaps_count
    assignment_pairs.select do |pair|
      range_1, range_2 = pair.split(',').map{_1.split("-").map(&:to_i)}

      overlaps? range_1, range_2
    end.size
  end

  def overlaps?(range_1, range_2)
    range_1[0] >= range_2[0] && range_1[0] <= range_2[1] ||
    range_1[1] >= range_2[0] && range_1[1] <= range_2[1] ||
    range_2[0] >= range_1[0] && range_2[0] <= range_1[1] ||
    range_2[1] >= range_1[0] && range_2[1] <= range_1[1]
  end
end
