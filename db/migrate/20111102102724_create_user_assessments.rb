class CreateUserAssessments < ActiveRecord::Migration
  def change
    create_table :user_assessments do |t|
      t.references :user
      t.references :learning_objective
      t.string :awareness
      t.string :guidance
      
      t.timestamps
    end
  end
end
