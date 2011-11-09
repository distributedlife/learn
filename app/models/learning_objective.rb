class LearningObjective < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :brief, :discipline, :category, :pending

  CATEGORIES = ['concept', 'responsibility', 'technique', 'artefact', 'lens']
  DISCIPLINES = ['automation', 'fundamentals', 'behaviour & functionality', 'user interaction', 'performance', 'security', 'domain knowledge', 'preparation & planning', 'infrastructure & integration', 'consultancy']

  validates :brief, :presence => true, :length => { :maximum => 500 }
  validates :brief, :uniqueness => {:scope => :discipline}
  validates_inclusion_of :category, :in => CATEGORIES
  validates_inclusion_of :discipline, :in => DISCIPLINES

  has_many :user_assessments, :class_name => "UserAssessments", :foreign_key => "learning_objective_id", :primary_key => "id"
  has_many :users, :through => :user_assessments

  scope :pending, where(:pending => true)
  
  def self.exists? id
    begin
      LearningObjective.find(id)

      true
    rescue
      false
    end
  end
  
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

  def approve!
    self.pending = false
    self.save!
  end

  def self.pending_for_user user_id
    sql = <<-SQL
      SELECT id
      FROM learning_objectives
      WHERE pending = false
      EXCEPT
      SELECT learning_objective_id
      FROM user_assessments
      WHERE user_id = #{user_id}
      AND (awareness = 'not assessed' or guidance = 'not assessed')
    SQL

    pending = ActiveRecord::Base.connection.execute(sql)
    LearningObjective.find(pending.map{|s| s['id']})
  end
end
