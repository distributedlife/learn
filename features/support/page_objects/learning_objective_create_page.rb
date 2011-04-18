class LearningObjectiveCreatePage < BasePage

  def initialize session
    super session
    @url = '/learning_objective/create'
  end

  def brief
    @session.find_field('lo_brief').text
  end

  def brief= value
    @session.fill_in('lo_brief', :with => value)
  end

  def discipline= discipline
    @session.execute_script "$(#{valid_dom_id(discipline)}).click();"
  end

  def category= category
    @session.execute_script "$(#{valid_dom_id(category)}).click();"
  end

  def save
    @session.click_on('save')
  end

  def create brief, discipline, category
    self.brief = brief
    self.discipline = discipline
    self.category = category

    self.save
  end
end