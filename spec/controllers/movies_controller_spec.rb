require 'spec_helper'

describe MoviesController do
  describe 'search movies by similar director' do
    before :each do
      @fake_results = [double('Movie')]
    end
    it 'should call the model method that performs similar director search with non-empty result' do
      Movie.should_receive(:find_with_similar_director).with('1').and_return(@fake_results)
      get :search_similar_director, {:id => 1}
    end
    it 'should call the model method that performs similar director search with empty result' do
      Movie.should_receive(:find_with_similar_director).with('3').and_return([])
      get :search_similar_director, {:id => 3}
    end
    describe 'after valid search' do
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
