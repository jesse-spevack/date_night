require './test/test_helper'
require './lib/score_movie'

class ScoreMovieTest < Minitest::Test
  def test_it_has_a_movie_and_score
    movie = "Bill & Ted's Excellent Adventure"
    score = 61

    data = ScoreMovie.new(score, movie)

    assert_equal score, data.score
    assert_equal movie, data.movie
  end
end
