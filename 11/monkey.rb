class Monkey

  def self.parse(input)
    # Monkey 0:
    # Starting items: 57, 58
    # Operation: new = old * 19
    # Test: divisible by 7
    #   If true: throw to monkey 2
    #   If false: throw to monkey 3

    lines = input.split(/\n/)

    new(
      id:         lines[0].match(MNK_ID_REGEX)[:id].to_i,
      items:      lines[1].match(ITEMS_REGEX)[:items].split(', ').map(&:to_i),
      op:         -> (old) { eval lines[2].match(OP_REGEX)[:operation] },
      test:       -> (v) { v % lines[3].match(TEST_REGEX)[:test].to_i == 0 },
      test_true:  lines[4].match(TEST_TRUE_REGEX)[:test_true].to_i,
      test_false: lines[5].match(TEST_FALSE_REGEX)[:test_false].to_i
    )
  end

  def initialize(id:, items:, op:, test:, test_true:, test_false:)
    @id = id
    @items = items
    @op = op
    @test = test
    @test_true = test_true
    @test_false = test_false
    @inspected_items_count = 0
  end

  attr_reader :id, :items, :op, :test, :test_true, :test_false, :inspected_items_count
  def round
    while items.delete_at(0)
                &.then { |it| @inspected_items_count += 1; it }
                &.then { |it| op.call(it) }
                &.then { |it| it / 3 }
                &.tap  { |it| yield(it, target_mnk(it)) if block_given? }; end

    self
  end

  def get_bored(item)
    item / 3
  end

  def target_mnk(item)
    test.call(item) ? test_true : test_false
  end

  private

  MNK_ID_REGEX      = /Monkey (?<id>\d+):/
  ITEMS_REGEX       = /Starting items: (?<items>.+)/
  OP_REGEX          = /Operation: new = (?<operation>.+)/
  TEST_REGEX        = /Test: divisible by (?<test>\d+)/
  TEST_TRUE_REGEX   = /  If true: throw to monkey (?<test_true>\d+)/
  TEST_FALSE_REGEX  = /  If false: throw to monkey (?<test_false>\d+)/

end
