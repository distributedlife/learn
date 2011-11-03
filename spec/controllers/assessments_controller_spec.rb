require 'spec_helper'

describe AssessmentsController do
  before(:each) do
    @user = User.make
    sign_in :user, @user

    request.env["HTTP_REFERER"] = "http://momentum.distributedlife.com"
  end

  context '"PUT" update' do
    it 'should redirect if learning not found' do
      a = UserAssessments.make(:user_id => @user.id, :learning_objective_id => 1)

      put :update, :learning_id => 1, :id => a.id, :user_assessment => {}

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should redirect if assessment not found' do
      p1 = LearningObjective.make

      put :update, :learning_id => p1.id, :id => 1, :user_assessment => {}

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should redirect if the assessment is not for the current user' do
      other_user = User.make

      p1 = LearningObjective.make
      a = UserAssessments.make(:user_id => other_user.id, :learning_objective_id => p1.id)

      put :update, :learning_id => p1.id, :id => a.id, :user_assessment => {:guidance => '', :awareness => ''}

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should redirect if the assessment is not for the learning objective' do
      p1 = LearningObjective.make
      p2 = LearningObjective.make
      a = UserAssessments.make(:user_id => @user.id, :learning_objective_id => p1.id)

      put :update, :learning_id => p2.id, :id => a.id, :user_assessment => {:guidance => '', :awareness => ''}

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should be valid' do
      p1 = LearningObjective.make
      a = UserAssessments.make(:user_id => @user.id, :learning_objective_id => p1.id)

      put :update, :learning_id => p1.id, :id => a.id, :user_assessment => {:guidance => '', :awareness => ''}

      a.reload
      UserAssessments.count.should == 1
      a.guidance.should_not == ""
      a.awareness.should_not == ""
    end

    it 'should update the assessment' do
      p1 = LearningObjective.make
      a = UserAssessments.make(:user_id => @user.id, :learning_objective_id => p1.id)

      put :update, :learning_id => p1.id, :id => a.id, :user_assessment => {:guidance => 'continual', :awareness => 'little'}

      a.reload
      UserAssessments.count.should == 1
      a.guidance.should == 'continual'
      a.awareness.should == 'little'
    end
  end
end
