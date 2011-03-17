class AddDisciplineToLearningObjective < ActiveRecord::Migration
  def self.up
    add_column :learning_objectives, :discipline, :string
  end

  def self.down
    remove_column :learning_objectives, :discipline
  end
end
