require 'spec_helper'

describe Movie do
  #fixtures :movies
  FactoryGirl.create(:movie, :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25')
  FactoryGirl.create(:movie, :title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25')
  FactoryGirl.create(:movie, :title => 'Alien', :rating => 'R', :director => '', :release_date => '1977-05-25')
  FactoryGirl.create(:movie, :title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11')
  describe 'searching movie by director' do
    it 'should call find Movie by director' do
      Movie.should_receive(:where).with(hash_including :director => 'George Lucas')
      Movie.find_with_similar_director('George Lucas')
    end
  end
end
