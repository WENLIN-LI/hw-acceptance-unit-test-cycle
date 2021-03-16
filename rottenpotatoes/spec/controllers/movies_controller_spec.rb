require 'rails_helper'
describe MoviesController do
  describe 'index_method' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end
  describe 'show_method' do
    it 'assigns the requested movie to @movie' do
      movie = FactoryGirl.create(:movie)
      get :show, id: movie.id
      expect(assigns(:movie)).to eq(movie)
    end
    it 'renders the :show view' do
      movie = FactoryGirl.create(:movie)
      get :show, id: movie.id
      expect(response).to render_template :show
    end
  end
  describe 'new_method' do
    it 'renders the :new view' do
      movie = FactoryGirl.create(:movie)
      get :new, id: movie.id
      expect(response).to render_template :new
    end
  end
  describe 'create_method' do
    it 'creates a new movie' do
      count= Movie.count
      post :create, movie:FactoryGirl.attributes_for(:movie)
      expect(Movie.count).to eq(count+1)
    end
    it 'leaves a notice' do
      movie = FactoryGirl.create(:movie)
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(flash[:notice]).to eq("#{movie.title} was successfully created.")
    end
    it 'redirects to the home page' do
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(response).to redirect_to(movies_path)
    end
  end
  describe 'edit_method' do
    it 'renders the :edit view' do
      movie = FactoryGirl.create(:movie)
      get :edit, id: movie.id
      expect(response).to render_template(:edit)
    end
  end
  describe 'update_method' do
    it 'assigns the requested movie to @movie' do
      @movie = FactoryGirl.create(:movie)
      put :update, id: @movie.id, movie: FactoryGirl.attributes_for(:movie)
      expect(assigns(:movie)).to eq(@movie)
    end

    it 'changes the title' do
      @movie = FactoryGirl.create(:movie)
      put :update, id: @movie.id, movie: FactoryGirl.attributes_for(:movie, title: 'changed')
      @movie.reload
      expect(@movie.title).to eq('changed')
    end

    it 'changes the rating' do
      @movie = FactoryGirl.create(:movie)
      put :update, id: @movie.id, movie: FactoryGirl.attributes_for(:movie, rating: 'changed')
      @movie.reload
      expect(@movie.rating).to eq('changed')
    end

    it 'changes the description' do
      @movie = FactoryGirl.create(:movie)
      put :update, id: @movie.id, movie: FactoryGirl.attributes_for(:movie, description: 'changed')
      @movie.reload
      expect(@movie.description).to eq('changed')
    end

    it 'changes the release date' do
      @movie = FactoryGirl.create(:movie)
      put :update, id: @movie.id, movie: FactoryGirl.attributes_for(:movie, release_date: Date.new(1997, 2, 3))
      @movie.reload
      expect(@movie.release_date).to eq(Date.new(1997, 2, 3))
    end

    it 'changes the director' do
      @movie = FactoryGirl.create(:movie)
      put :update, id: @movie.id, movie: FactoryGirl.attributes_for(:movie, director: 'changed')
      @movie.reload
      expect(@movie.director).to eq('changed')
    end

    it 'redirects to the updated movie' do
      @movie = FactoryGirl.create(:movie)
      put :update, id: @movie.id, movie: FactoryGirl.attributes_for(:movie)
      expect(response).to redirect_to(movie_path(@movie))
    end
  end
  describe 'destroy_method' do
    it 'deletes the movie' do
      @movie = FactoryGirl.create(:movie)
      count=Movie.count
      delete :destroy, id: @movie.id
      expect(Movie.count).to eq(count-1)
    end

    it 'redirects to the home page' do
      @movie = FactoryGirl.create(:movie)
      delete :destroy, id: @movie.id
      expect(response).to redirect_to(movies_path)
    end
  end
  describe 'similar_method' do
    before :each do
      @movie1 = FactoryGirl.create(:movie)
      @movie2 = FactoryGirl.create(:movie, title: 'similar', director: 'Frank Darabont')
      @movie3 = FactoryGirl.create(:movie, title: 'not similar', director: 'Tom')
      @movie4 = FactoryGirl.create(:movie, director: nil)
    end
    context 'when the specified movie has a director' do
      it 'pass similar movies to @movie' do
        get :same_director, id: @movie1.id
        expect(assigns(:similar_movies)).to include(@movie2)
      end
      it 'renders the :similar view' do
        @movie1 = FactoryGirl.create(:movie)
        get :same_director, id:  @movie1.id
        expect(response).to render_template(:same_director)
      end
    end
    context 'when the specified movie has no director' do
      it 'leaves a notice' do
        get :same_director, id: @movie4.id
        expect(flash[:notice]).to eq("#{@movie4.title} has no director info")
      end

      it 'redirects to the home page' do
        get :same_director, id: @movie4.id
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end