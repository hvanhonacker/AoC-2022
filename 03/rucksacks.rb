require 'set'

class Rucksacks
  def self.from_data(data)
    rucksacks = File.read(data).split(/\n/)

    new(rucksacks.map { |rucksack_content| Rucksack.new(rucksack_content) })
  end

  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def sum_of_priorities
    res = 0

    @rucksacks.each_slice(3) do |rucksacks_group|
      res += ItemType.new(rucksacks_group.reduce(&:intersection).content).priority
    end

    res
  end
end

class Rucksack

  attr_reader :content

  def initialize(content)
    @content = content
  end

  def common_item_type_priority
    item_type_priority(common_item_type)
  end
  alias_method :priority, :common_item_type_priority

  def intersection(other_rucksack)
    Rucksack.new(
      item_types.intersection(other_rucksack.item_types).join ''
    )
  end

  def item_types
    Set.new(content.split(''))
  end
end

class ItemType
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def priority
    ITEM_TYPES.index(value) + 1
  end

  ITEM_TYPES = [('a'..'z'), ('A'..'Z')].map(&:to_a).join
end
