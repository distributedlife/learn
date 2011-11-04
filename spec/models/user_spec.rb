require 'spec_helper'

describe User do
  context 'create new user' do
    it 'should allow account creation' do
      result = User.new(:email => "a@b.com", :password => "password", :password_confirmation => "password").save!
      result.should == true

      user =  User.first
      user.email.should == "a@b.com"
    end

    it 'should not allow an account to exist if the email has been used' do
      User.new(:email => "a@b.com", :password => "password", :password_confirmation => "password").save!

      lambda { User.new(:email => "a@b.com", :password => "password", :password_confirmation => "password").save! }.should raise_error

      User.count.should == 1
    end

    it 'should not allow account creation if the passwords are not equal' do
      lambda { User.new(:email => "a@b.com", :password => "password", :password_confirmation => "passwords").save! }.should raise_error

      User.count.should == 0
    end
  end

  describe 'learning_objectives' do
    it 'should get the users learning objectives' do
      user = User.make
      l1 = LearningObjective.make
      l2 = LearningObjective.make
      UserAssessments.make(:user_id => user.id, :learning_objective_id => l1.id)
      UserAssessments.make(:user_id => user.id, :learning_objective_id => l2.id)

      user.learning_objectives.count.should == 2
      user.learning_objectives.include?(l1).should == true
      user.learning_objectives.include?(l2).should == true
    end
  end

  describe 'get_assessment' do
    it 'should get the users learning objective assessment' do
      user = User.make
      l1 = LearningObjective.make
      l2 = LearningObjective.make
      ul1a = UserAssessments.make(:user_id => user.id, :learning_objective_id => l1.id)
      ul2a = UserAssessments.make(:user_id => user.id, :learning_objective_id => l2.id)

      user.get_assessment(l1.id).should == ul1a
      user.get_assessment(l2.id).should == ul2a
    end
  end

  describe 'get user assessments for discipline' do
    it 'should return only learnings for the current user' do
      user = User.make
      user2 = User.make
      l1 = LearningObjective.make(:discipline => "automation")
      l2 = LearningObjective.make(:discipline => "automation")
      ul1a = UserAssessments.make(:user_id => user.id, :learning_objective_id => l1.id)
      ul2a = UserAssessments.make(:user_id => user2.id, :learning_objective_id => l2.id)

      r = user.user_assessments.for_discipline 'automation'
      r.include?(ul1a).should == true
      r.include?(ul2a).should_not == true
    end

    it 'should return only learnings for the specified discipline' do
      user = User.make
      l1 = LearningObjective.make(:discipline => "automation")
      l2 = LearningObjective.make(:discipline => "automation")
      l3 = LearningObjective.make(:discipline => "fundamentals")
      ul1a = UserAssessments.make(:user_id => user.id, :learning_objective_id => l1.id)
      ul2a = UserAssessments.make(:user_id => user.id, :learning_objective_id => l2.id)
      ul3a = UserAssessments.make(:user_id => user.id, :learning_objective_id => l3.id)

      r = user.user_assessments.for_discipline 'automation'
      r.include?(ul1a).should == true
      r.include?(ul2a).should == true
      r.include?(ul3a).should_not == true

      r = user.user_assessments.for_discipline 'fundamentals'
      r.include?(ul1a).should_not == true
      r.include?(ul2a).should_not == true
      r.include?(ul3a).should == true
    end
  end

  describe 'get user learning objectives for discipline' do
    it 'should return only learnings for the current user' do
      user = User.make
      user2 = User.make
      l1 = LearningObjective.make(:discipline => "automation")
      l2 = LearningObjective.make(:discipline => "automation")
      UserAssessments.make(:user_id => user.id, :learning_objective_id => l1.id)
      UserAssessments.make(:user_id => user2.id, :learning_objective_id => l2.id)

      r = user.learning_objectives.for_discipline 'automation'
      r.include?(l1).should == true
      r.include?(l2).should_not == true
    end

    it 'should return only learnings for the specified discipline' do
      user = User.make
      l1 = LearningObjective.make(:discipline => "automation")
      l2 = LearningObjective.make(:discipline => "automation")
      l3 = LearningObjective.make(:discipline => "fundamentals")
      UserAssessments.make(:user_id => user.id, :learning_objective_id => l1.id)
      UserAssessments.make(:user_id => user.id, :learning_objective_id => l2.id)
      UserAssessments.make(:user_id => user.id, :learning_objective_id => l3.id)

      r = user.learning_objectives.for_discipline 'automation'
      r.include?(l1).should == true
      r.include?(l2).should == true
      r.include?(l3).should_not == true

      r = user.learning_objectives.for_discipline 'fundamentals'
      r.include?(l1).should_not == true
      r.include?(l2).should_not == true
      r.include?(l3).should == true
    end
  end
end