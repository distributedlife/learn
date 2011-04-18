Given /^I am on the propose learning objective page$/ do
  @current_page = LearningObjectiveCreatePage.new(Capybara.current_session)
  @current_page.visit
end

Given /^I am on the learning objectives page$/ do
  @current_page = LearningObjectiveSearchPage.new(Capybara.current_session)
  @current_page.visit
end

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

Given /^one learning objective in all permutations$/ do
  category = 0
  category_done = false
  discipline = 0
  discipline_done = false

  until category_done and discipline_done
    LearningObjective.make(:discipline => LearningObjective::DISCIPLINES[discipline], :category => LearningObjective::CATEGORIES[category])

    category += 1
    discipline += 1

    if category == LearningObjective::CATEGORIES.length
      category = 0
      category_done = true ;
    end
    if discipline == LearningObjective::DISCIPLINES.length
      discipline = 0
      discipline_done = true ;
    end
  end
end

Given /^a pending learning objective$/ do
  LearningObjective.make(:pending => true)
end

Given /^the following pending learning objective "([^"]*)"$/ do |brief|
  LearningObjective.make(:pending => true, :brief => brief)
end

Given /^pending learning objectives are shown$/ do
  @current_page.show_pending
end

Given /^all learning objectives are automagically approved$/ do
  LearningObjective.all.each do |lo|
    lo.pending = false
    lo.save!
  end
end


When /^I search for "([^"]*)"$/ do |search_term|
  @current_page.search_for search_term
end

When /^I create a learning objective with:$/ do |lo_properties|
  lo_properties.hashes.map do |lo|
    @current_page.create lo["brief"], lo["discipline"], lo["category"]
  end
end

When /^I go to the learning objectives page$/ do
  @current_page = LearningObjectiveSearchPage.new(Capybara.current_session)
  @current_page.visit
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

Then /^I should see the link "([^"]*)"$/ do |text|
  find_link(text)
end

Then /^the brief field is empty$/ do
  @current_page.brief.should == ""
end