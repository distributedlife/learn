Given /^no learning objectives$/ do
  LearningObjective.delete_all
end

Given /^the learning objective "([^"]*)"$/ do |text|
  lo = LearningObjective.new
  lo.brief = text
  lo.save!

  unless defined? @learning_objectives
    @learning_objectives = Array.new
  end
  
  @learning_objectives.push(lo)
end

Given /^(\d+) learning objectives containing "([^"]*)"$/ do |count, text|
  count.to_i.times do
    lo = LearningObjective.new
    lo.brief = "#{text} #{Faker::Lorem.paragraph(3)}"
    lo.save!
  end
end


When /^I search for "([^"]*)"$/ do |search_term|
  fill_in('q', :with => search_term)
  click_on('Search')
end

Then /^each learning objective is displayed on the page alphabetically$/ do
  @learning_objectives.count.should_not be 0
  @learning_objectives.sort! { |a,b| a.brief.downcase <=> b.brief.downcase }

  displayed_learning_objectives = all('p.even') + all('p.odd')
  @learning_objectives.count.should == displayed_learning_objectives.count

  #for each paragraph element on the page check to see if it matches an
  #element in learning_objectives at the same index
  displayed_learning_objectives.each_with_index do |element, i|
    lo = @learning_objectives[i]
    element.text.should == lo.brief
  end
end