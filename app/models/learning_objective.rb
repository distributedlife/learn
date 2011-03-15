class LearningObjective < ActiveRecord::Base
  attr_accessible :brief
  
  validates :brief, :presence => true, :length => { :minimum => 1, :maximum => 500 }

  def self.search(search_term)
    search_term = "%#{search_term}%"
    self.find(:all, :conditions => ["brief like ?", search_term])
  end
end
