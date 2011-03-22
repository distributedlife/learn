class ChangeLengthOfLearningObjectiveBrief < ActiveRecord::Migration
  def self.up
    change_column :learning_objectives, :brief, :string, :limit => 500
  end

  def self.down
    change_column :learning_objectives, :brief, :string, :limit => 255
  end
end
