require 'rails_helper'

RSpec.describe MoviesController, :type => :controller do
  # render_views

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "should render movies#show template" do
      movie = instance_double(Movie, id: 1, title: "Fake Movie")
      allow(Movie).to receive(:find).with(movie.id.to_s).and_return(movie)

      get :show, id: movie.id

      expect(assigns(:movie)).to eq(movie)
      expect(Movie).to have_received(:find).with(movie.id.to_s).once
      expect(response).to render_template(:show)
      expect(response.code).to eq('200')
    end
  end

  describe "GET #edit" do
    it "should render movies#edit template" do 
      movie = instance_double(Movie, id: 1, title: "Fake Movie")
      allow(Movie).to receive(:find).with(movie.id.to_s).and_return(movie)

      get :edit, id: movie.id

      expect(assigns(:movie)).to eq(movie)
      expect(Movie).to have_received(:find).with(movie.id.to_s).once
      expect(response).to render_template(:edit)
      expect(response.code).to eq('200')
    end
  end

  describe "director" do
    context "When specified movie has a director" do
      it "find movies with the same director" do
        @id = "-1"
        @movie = double('new_movie', director: 'Alex')
        expect(Movie).to receive(:find).with(@id).and_return(@movie)
        expect(@movie).to receive(:movies_by_director)
        
        get :show_movies_director, id: @id
        expect(response).to render_template(:movies_director)
      end
    end
    
    context "When specified movie has no director" do
      it "redirect to the movies page" do
        @id = "-1"
        @movie = double('null movie').as_null_object
        expect(Movie).to receive(:find).with(@id).and_return(@movie)
        
        get :show_movies_director, id: @id
        expect(response).to redirect_to(movies_path)
      end
    end
  end

  describe "create" do
    it "create movie with provided parameters" do
      @defaults = {title: "New_Movie", rating: "R", director: "Bill"}
      
      post :create, movie: @defaults
      expect(flash[:notice]).to eq("New_Movie was successfully created.")
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe "show" do
    it "display details about an existing movie" do
      @id = "-1"
      @movie = double('null movie').as_null_object
      expect(Movie).to receive(:find).and_return(@movie)
      get :show, id: @id
      expect(response).to render_template(:show)
    end
  end
  
  describe "destroy" do
    it "delete the specific movie" do
      @id = "-1"
      @movie = double('null movie').as_null_object
      expect(Movie).to receive(:find).with(@id).and_return(@movie)
      
      delete :destroy, id: @id
      expect(flash[:notice]).to match(/Movie || deleted./)
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe "edit" do
    it "edit an existing movie" do
      @id = "-1"
      @movie = double('null movie').as_null_object
      expect(Movie).to receive(:find).and_return(@movie)
      
      get :edit, id: @id
      expect(response).to render_template(:edit)
    end
  end
  
  describe "new" do
    it "render the new template" do
      get :new 
      expect(response).to render_template(:new)
    end
  end
  
  describe "update" do
    it "update existing movie" do
      @id = "-1"
      @movie = double('null movie').as_null_object
      @defaults = {title: "New_Movie", rating: "R", director: "Bill"}
      expect(Movie).to receive(:find).with(@id).and_return(@movie)
      
      put :update, id: @id, movie: @defaults
      expect(flash[:notice]).to match(/was successfully updated./)
      expect(response).to redirect_to(movie_path(@movie))
    end
  end
  
  describe "sorting movies" do
    it "sort with selected_ratings" do 
      get :index, sort: "title"
      expect(response.body).to include "ratings"
    end
    it "sort with release_date" do 
      get :index, sort: "release_date"
      expect(response.body).to include "release_date"
    end 
  end
end