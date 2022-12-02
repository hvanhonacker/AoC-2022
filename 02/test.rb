require "minitest/autorun"

require "./tournament"

class TournamentTest < Minitest::Test
  def test_that_the_tournament_total_score_is_correct
    tournament = Tournament.new_from_input('input-test.txt')

    assert_equal 15, tournament.total_score
  end
end

class TournamentRoundTest < Minitest::Test
  def test_round_result_that_rocks_defeats_scissors
    round = Tournament::Round.new('C', 'X')

    assert_equal :win, round.result
  end

  def test_round_result_when_rocks_defeats_scissors
    round = Tournament::Round.new('C', 'X')

    assert_equal 1 + 6, round.score
  end
end

