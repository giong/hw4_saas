Given(/^the following movies exist:$/) do |movies_table|
  # table is a Cucumber::Ast::Table
  movies_table.hashes.each do |movie|
    Movie.create! movie
  end
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |movie_title, movie_director|
  step %{I should see "#{movie_director}"}
end
