class Movie < ActiveRecord::Base

  scope :movies_director, -> (director) { where(director: director) }

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def movies_by_director
    Movie.movies_director(self.director)
  end

end
