Sham.define do
  brief  { Faker::Lorem.paragraphs(1) }
end

def create_learning_objective(brief)
  @lo = LearningObjective.new
  @lo.brief = brief
  @lo.save
end