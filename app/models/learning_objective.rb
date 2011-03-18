class LearningObjective < ActiveRecord::Base
  attr_accessible :brief, :discipline, :category
  
  CATEGORIES = ['concept', 'responsibility', 'technique', 'artefact', 'lens']
  DISCIPLINES = ['automation', 'fundamentals', 'behaviour & functionality', 'user interaction', 'performance', 'security', 'domain knowledge', 'preparation & planning']

  validates :brief, :presence => true, :length => { :minimum => 1, :maximum => 500 }
  validates :discipline, :presence => true
  validates :category, :presence => true
  validates_inclusion_of :category, :in => CATEGORIES
  validates_inclusion_of :discipline, :in => DISCIPLINES

  
  def self.search(search_term)
    search_term = "%#{search_term}%"
    self.find(:all, :conditions => ["brief like ? or discipline like ? or category like ?", search_term, search_term, search_term])
  end
end
