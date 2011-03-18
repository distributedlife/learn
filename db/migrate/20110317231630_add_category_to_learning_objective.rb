class AddCategoryToLearningObjective < ActiveRecord::Migration
  def self.up
    add_column :learning_objectives, :category, :string
  end

  def self.down
    remove_column :learning_objectives, :category
  end
end
