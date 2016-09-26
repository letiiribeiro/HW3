Given (/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie| 
    Movie.create!(movie)
  end
end

When (/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
    rate = rating_list.gsub(",", "").split
    if uncheck == nil
        rate.each_with_index do |field, index|
             step %Q{I check "ratings[#{field}]"}
        end
    else
        rate.each_with_index do |field, index|
            step %Q{I uncheck "ratings[#{field}]"}
        end
    end
end

Then (/I should see all of the movies/) do
     Movie.find(:all).count.should == page.all('table tbody tr').count
end