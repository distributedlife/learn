class Definitions < ActiveRecord::Base
  attr_accessible :name, :description, :topic

  validates :name, :presence => true
  validates :description, :presence => true
  validates :topic, :presence => true
end
