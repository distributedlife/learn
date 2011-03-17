def create_learning_objective(brief, discipline)
#  @lo = LearningObjective.make(:brief => brief, :discipline => discipline)
  @lo = LearningObjective.new
  @lo.brief = brief
  @lo.discipline = discipline
  @lo.save
end