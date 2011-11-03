class UserAssessments < ActiveRecord::Base
  has_many :users, :class_name => "User", :foreign_key => "id", :primary_key => "user_id"
  has_many :learning_objectives, :class_name => "LearningObjective", :foreign_key => "id", :primary_key => "learning_objective_id"

  attr_accessible :user_id, :learning_objective_id, :awareness, :guidance

  AWARENESS = ['not assessed', 'little', 'some', 'full']
  GUIDANCE = ['not assessed', 'continual', 'some', 'none']

  validates_inclusion_of :awareness, :in => AWARENESS
  validates_inclusion_of :guidance, :in => GUIDANCE

  def self.exists? id
    begin
      UserAssessments.find(id)

      true
    rescue
      false
    end
  end
end
