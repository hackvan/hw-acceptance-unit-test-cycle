require 'rails_helper'

RSpec.describe Movie, :type => :model do
  # subject { described_class.new }

  context "with a director attribute" do
    it "with valid director attribute" do
      subject.title    = "title"
      subject.rating   = "G"
      subject.director = "director movie"
      expect(subject).to be_valid
    end

    describe "similar_movies" do
      it "find movies by the same director" do
        movie1 = Movie.create! director: 'Steven Spielberg'
        movie2 = Movie.create! director: 'Steven Spielberg'
        expect(movie1.movies_by_director).to include(movie2)
      end
      it "not find movies by different directors" do
        movie1 = Movie.create! director: 'Steven Spielberg'
        movie2 = Movie.create! director: 'James Cameron'
        expect(movie1.movies_by_director).not_to include(movie2)
      end
    end
  end
end