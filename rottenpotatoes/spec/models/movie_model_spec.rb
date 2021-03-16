require 'rails_helper'

describe Movie do
  describe 'find_similar_movies' do
    context 'when the specified movie has a director' do
      it 'finds similar movies correctly' do
        @movie1 = FactoryGirl.create(:movie)
        @movie2 = FactoryGirl.create(:movie, title: 'similar', director: 'Frank Darabont')
        expect(Movie.similar_movies(@movie2.id)).to include(@movie1)
      end
    end

    context 'when the specified movie has no director' do
      it 'handles sad path' do
        @movie1 = FactoryGirl.create(:movie)
        @movie3 = FactoryGirl.create(:movie, director: nil)
        expect(Movie.similar_movies(@movie3.id)).to eq(nil)
      end
    end
    
  end

  describe 'all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end