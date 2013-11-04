require 'spec_helper'

describe Movie do
  fixtures :movies
  describe 'searching movie by director' do
    it 'should call find Movie by director' do
      Movie.should_receive(:where).with(hash_including :director => 'George Lucas')
      Movie.find_with_similar_director('George Lucas')
    end
  end
end
