require 'spec_helper'

describe MoviesController do
  #happy path
  describe 'search movies by similar director with non-empty director' do
    it 'should call the model method that find the movie by id' do
      fake_movie = double('Movie', :director => 'George Lucas')
      Movie.should_receive(:find).with('1').and_return(fake_movie)
      get :search_similar_director, {:id => 1}
    end 
    describe 'after find movie by id' do
      before :each do
        fake_movie = double('Movie', :director => 'George Lucas')
        Movie.stub(:find).and_return(fake_movie)
        @fake_results = [double('Movie'), double('Movie')]
      end
      it 'should call the model method that performs similar director search with non-empty result' do
        Movie.should_receive(:find_with_similar_director).with('George Lucas').and_return(@fake_results)
        get :search_similar_director, {:id => 1}
      end
      describe 'after find movie by director' do
        before :each do
          Movie.stub(:find_with_similar_director).and_return(@fake_results)
          get :search_similar_director, {:id => 1}
        end
        it 'should select the Search Results template for rendering' do
          response.should render_template('search_similar_director')
        end
        it 'should make the search results available to that template' do
          assigns(:movies).should == @fake_results
        end
      end
    end
  end
  #sad path
  describe 'search movies by similar director with empty director' do
     it 'should call the model method that find the movie by id' do
       fake_movie = double('Movie', :title => 'Alien', :director => "")
       Movie.should_receive(:find).with('3').and_return(fake_movie)
       get :search_similar_director, {:id => 3}
     end
     it 'should redirect to home page' do
       fake_movie = double('Movie', :title => 'Alien', :director => "")
       Movie.should_receive(:find).with('3').and_return(fake_movie)
       response.should render_template('index')
     end
   end
end
