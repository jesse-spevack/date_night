class ScoreMovie
  attr_reader :score,
              :movie

  def initialize(score, movie)
    @score = score
    @movie = movie
  end
end
