def create_learning_objective(brief, discipline, category)
  LearningObjective.make(:brief => brief, :discipline => discipline, :category => category)
end