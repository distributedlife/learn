class LearningObjective < ActiveRecord::Base
  attr_accessible :brief, :discipline
  
  validates :brief, :presence => true, :length => { :minimum => 1, :maximum => 500 }
  validates :discipline, :presence => true, :length => { :minimum => 1, :maximum => 50 }

  def self.search(search_term)
    search_term = "%#{search_term}%"
    self.find(:all, :conditions => ["brief like ? or discipline like ?", search_term, search_term])
  end
end
