require "minitest/autorun"

require "./tournament"

class TournamentTest < Minitest::Test
  def test_that_the_tournament_total_score_is_correct
    tournament = Tournament.new_from_input('input-test.txt')

    assert_equal 12, tournament.total_score
  end
end

class TournamentRoundTest < Minitest::Test
  def test_round_infers_our_play
    round = Tournament::Round.new('A', 'Y')
    assert_equal :rock, round.our_play

    round = Tournament::Round.new('B', 'X')
    assert_equal :rock, round.our_play

    round = Tournament::Round.new('C', 'Z')
    assert_equal :rock, round.our_play
  end

  def test_round_score_is_correct
    round = Tournament::Round.new('A', 'Y')
    assert_equal 1 + 3, round.score

    round = Tournament::Round.new('B', 'X')
    assert_equal 1 + 0, round.score

    round = Tournament::Round.new('C', 'Z')
    assert_equal 1 + 6, round.score
  end
end

