Given /^no learning objectives$/ do
  LearningObjective.delete_all
end

Given /^the learning objective "([^"]*)" in the "([^"]*)" discipline$/ do |brief, discipline|
  lo = LearningObjective.make(:brief => brief, :discipline => discipline)

  unless defined? @learning_objectives
    @learning_objectives = Array.new
  end
  
  @learning_objectives.push(lo)
end

Given /^the "([^"]*)" "([^"]*)" in the "([^"]*)" discipline$/ do |category, brief, discipline|
  LearningObjective.make(:category => category, :brief => brief, :discipline => discipline)
end

Given /^(\d+) learning objectives containing "([^"]*)"$/ do |count, text|
  count.to_i.times do
    lo = LearningObjective.make(:brief => "#{text} #{Faker::Lorem.paragraph(3)}")
  end
end


When /^I search for "([^"]*)"$/ do |search_term|
  fill_in('q', :with => search_term)
  click_on('Search')
end


Then /^each learning objective is displayed on the page alphabetically$/ do
  @learning_objectives.count.should_not be 0
  @learning_objectives = @learning_objectives.sort_by { |a| [a.discipline.downcase, a.brief.downcase] }

  
  displayed_learning_objective_brief = all('p#brief')
  displayed_learning_objective_discipline = all('span#discipline')
  displayed_learning_objective_categories = all('span#category')


  @learning_objectives.count.should == displayed_learning_objective_brief.count
  @learning_objectives.count.should == displayed_learning_objective_discipline.count
  @learning_objectives.count.should == displayed_learning_objective_categories.count

  #for each paragraph element on the page check to see if it matches an
  #element in learning_objectives at the same index
  @learning_objectives.each_with_index do |lo, i|
    discipline = displayed_learning_objective_discipline[i]
    brief = displayed_learning_objective_brief[i]
    category = displayed_learning_objective_categories[i]

    brief.text.should == lo.brief
    discipline.text.should == lo.discipline.upcase
    category.text.should == lo.category.upcase
  end
end