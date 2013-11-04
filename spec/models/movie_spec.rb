require 'spec_helper'

describe Movie do
  fixtures :movies
  describe 'searching tmdb by director' do
    it 'should call find Movie by id' do
      fake_result = double('Movie', :director => 'George Lucas')
      Movie.should_receive(:find).with(1).and_return(fake_result)
      Movie.find_with_similar_director(1)
    end
    it 'should call find Movie by director' do
      Movie.should_receive(:where).with(hash_including :director => 'George Lucas')
      Movie.find_with_similar_director(1)
    end
  end
end
