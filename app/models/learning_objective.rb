class LearningObjective < ActiveRecord::Base
  attr_accessible :brief
  
  validates :brief, :presence => true, :length => { :minimum => 1, :maximum => 500 }
end
