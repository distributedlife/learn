class CreateLearningObjectives < ActiveRecord::Migration
  def self.up
    create_table :learning_objectives do |t|
      t.string :brief

      t.timestamps
    end
  end

  def self.down
    drop_table :learning_objectives
  end
end
