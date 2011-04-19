class LearningObjectiveCreatePage < BasePage

  def initialize session
    super session
    @url = '/learning_objective/create'
  end

  def brief
    @session.find_field('learning_objective_brief').text
  end

  def brief= value
    @session.fill_in('learning_objective_brief', :with => value)
  end

  def discipline= discipline
    @session.choose(discipline)
  end

  def category= category
    @session.choose(category)
  end

  def save
    @session.click_on('propose')
  end

  def create brief, discipline, category
    self.brief = brief
    self.discipline = discipline
    self.category = category

    self.save
  end
end