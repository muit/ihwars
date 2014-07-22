require 'pry'
class RankingManager
  def initialize(points)
    @points = points
  end

  def byPopularity
    @points.sort_by {|point| point.popularity}.reverse
  end

  def byComments
    @points.sort_by {|point| point.getNumberOfComments}.reverse
  end

  def byNumberOfWords
    @points.sort_by {|point| point.getNumberOfWords}.reverse
  end

end

class Point
  attr_accessor :popularity
  def initialize(popularity, commentaries)
    @popularity = popularity
    @commentaries = commentaries
  end
  def getNumberOfWords
    number = 0

    @commentaries.each do |commentarie|
      number += commentarie.split(" ").length
    end

    return number
  end
  def getNumberOfComments
    @commentaries.length
  end

end