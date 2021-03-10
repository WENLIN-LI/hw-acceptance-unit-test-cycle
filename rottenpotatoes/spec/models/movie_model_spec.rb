require 'rails_helper'

describe Movie do
  describe 'find_similar_movies' do
    @movie1 = FactoryGirl.create(:movie)
    @movie2 = FactoryGirl.create(:movie, title: 'similar', director: 'Frank Darabont')
    @movie3 = FactoryGirl.create(:movie, title: 'not similar', director: 'Tom')
    @movie4 = FactoryGirl.create(:movie, director: nil)
    id = @movie1.id

    context 'when the specified movie has a director' do
      it 'finds similar movies correctly' do
        expect(Movie.similar_movies(id)) == [@movie1,@movie2]
      end
    end

    context 'when the specified movie has no director' do
      it 'handles sad path' do
        expect(Movie.similar_movies(id)) == nil
      end
    end
    
  end

  describe 'all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end