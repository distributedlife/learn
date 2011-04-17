class LearningObjective < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :brief, :discipline, :category, :pending

  CATEGORIES = ['concept', 'responsibility', 'technique', 'artefact', 'lens']
  DISCIPLINES = ['automation', 'fundamentals', 'behaviour & functionality', 'user interaction', 'performance', 'security', 'domain knowledge', 'preparation & planning', 'infrastructure & integration']

  validates :brief, :presence => true, :length => { :maximum => 500 }
  validates :brief, :uniqueness => {:scope => :discipline}
  validates_inclusion_of :category, :in => CATEGORIES
  validates_inclusion_of :discipline, :in => DISCIPLINES

  
  def self.search(search_term, discipline_filter = nil, category_filter = nil, show_pending = false)
    search_term = "%#{search_term}%".downcase


    #use all disciplines if none supplied
    discipline_filter = DISCIPLINES if (discipline_filter.nil? or discipline_filter.empty?)

    #use all categories if none supplied
    category_filter = CATEGORIES if (category_filter.nil? or category_filter.empty?)

    #set pending to show both if set to true
    show_pending = [true, false] if show_pending == true


    self.find(:all, :conditions => ["brief like ? and discipline in (?) and category in (?) and pending in (?)", search_term, discipline_filter, category_filter, show_pending])
  end


  def self.trim_invalid_disciplines(disciplines)
    unless disciplines.kind_of?(Array)
      disciplines = [disciplines]
    end
    
    DISCIPLINES & disciplines
  end


  def self.trim_invalid_categories(categories)
    unless categories.kind_of?(Array)
      categories = [categories]
    end

    CATEGORIES & categories
  end
end
