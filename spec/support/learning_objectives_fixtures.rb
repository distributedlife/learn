def create_learning_objective(brief, discipline)
  @lo = LearningObjective.make(:brief => brief, :discipline => discipline)
end