class Monkey

  def self.parse(input)
    lines = input.split(/\n/)

    new(
      id:         lines[0].match(MNK_ID_REGEX)[:id].to_i,
      items:      lines[1].match(ITEMS_REGEX)[:items].split(', ').map(&:to_i),
      op:         -> (old) { eval lines[2].match(OP_REGEX)[:operation] },
      divider:    lines[3].match(DIVIDER_REGEX)[:divider].to_i,
      test_true:  lines[4].match(TEST_TRUE_REGEX)[:test_true].to_i,
      test_false: lines[5].match(TEST_FALSE_REGEX)[:test_false].to_i
    )
  end

  def initialize(id:, items:, op:, divider:, test_true:, test_false:)
    @id = id
    @items = items
    @op = op
    @divider = divider
    @test_true = test_true
    @test_false = test_false
    @inspected_items_count = 0
  end

  attr_reader :id, :items, :op, :divider, :test_true, :test_false, :inspected_items_count

  DEFAULT_WORRY_MOD = ->(item) { item / 3 }

  def round(worry_mod: nil)
    worry_mod ||= DEFAULT_WORRY_MOD

    while items.delete_at(0)
                &.then { |it| @inspected_items_count += 1; it }
                &.then { |it| op.call(it) }
                &.then { |it| worry_mod.call(it) }
                &.tap  { |it| yield(it, target_mnk(it)) if block_given? }; end

    self
  end

  def caaatch(item)
    self.items << item
  end

  def target_mnk(item)
    item % divider == 0 ? test_true : test_false
  end

  private

  MNK_ID_REGEX      = /Monkey (?<id>\d+):/
  ITEMS_REGEX       = /Starting items: (?<items>.+)/
  OP_REGEX          = /Operation: new = (?<operation>.+)/
  DIVIDER_REGEX     = /Test: divisible by (?<divider>\d+)/
  TEST_TRUE_REGEX   = /  If true: throw to monkey (?<test_true>\d+)/
  TEST_FALSE_REGEX  = /  If false: throw to monkey (?<test_false>\d+)/
end
