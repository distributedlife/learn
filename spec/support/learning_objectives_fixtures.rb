def create_learning_objective(brief, discipline, category)
  LearningObjective.make(:brief => brief, :discipline => discipline, :category => category)
end

def create_pending_learning_objective(brief, discipline, category)
  LearningObjective.make(:brief => brief, :discipline => discipline, :category => category, :pending => true)
end