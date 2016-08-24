class Node
  def initialize(score, movie)
    @score = score
    @movie = movie
  end

  def data
    [@score, @movie]
  end
end
