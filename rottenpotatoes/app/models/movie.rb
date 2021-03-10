class Movie < ActiveRecord::Base
  def self.all_ratings
    ["G", "PG", "PG-13", "NC-17", "R"]  
  end
  def self.similar_movies id
    director = Movie.find(id).director
    return nil if director.blank? || director.nil?
    Movie.where(:director => director)
  end
end
