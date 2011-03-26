class AddPendingToLearningObjective < ActiveRecord::Migration
  def self.up
    add_column :learning_objectives, :pending, :boolean, :default => true
  end

  def self.down
    remove_column :learning_objectives, :pending
  end
end
