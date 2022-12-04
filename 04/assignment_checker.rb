
class AssignmentChecker
  def initialize(input_file)
    @assignments = File.read(input_file).split(/\n/)
  end

  attr_reader :assignments

  def full_overlaps_count
    assignments.select do |ranges|
      range_1, range_2 = ranges.split(',').map{_1.split("-").map(&:to_i)}

      range_1[0] >= range_2[0] && range_1[1] <= range_2[1] ||
        range_2[0] >= range_1[0] && range_2[1] <= range_1[1]
    end.size
  end
end
