require './lib/score_movie'

class Node
  attr_reader :data

  attr_accessor :left,
                :right

  def initialize(score, movie)
    @data = ScoreMovie.new(score, movie)
    @left
    @right
  end

  def score
    data.score
  end

  def movie
    data.movie
  end

  def left_full?
    left.class == Node
  end

  def right_full?
    right.class == Node
  end

  def has_children?
    left_full? && right_full?
  end

end
