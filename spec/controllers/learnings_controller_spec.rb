require 'spec_helper'

describe LearningsController do
  before(:each) do
    @user = User.make
    sign_in :user, @user

    request.env["HTTP_REFERER"] = "http://momentum.distributedlife.com"
  end
  
  context '"GET" new' do
  end

  context '"POST" create' do
    it 'should be valid' do
      post :create, :learning_objective => { :brief => "" }

      LearningObjective.count.should == 0
      assigns[:learning].brief.should == ""
      assigns[:learning].errors.empty?.should == false
    end

    it 'should create a new learning' do
      post :create, :learning_objective => { :brief => "testing is good", :discipline => "automation", :category => "concept" }

      LearningObjective.count.should == 1
      LearningObjective.first.brief.should == "testing is good"
      LearningObjective.first.discipline.should == "automation"
      LearningObjective.first.category.should == "concept"
      LearningObjective.first.pending.should == true
    end
  end

  context '"GET" show' do
    it 'should redirect if learning not found' do
      get :show, :id => 1

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should return the specified learning' do
      p1 = LearningObjective.make

      get :show, :id => p1.id

      assigns[:learning].should == p1
    end
  end

  context '"PUT" approve!' do
    it 'should redirect if learning not found' do
      put :approve, :id => 1

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should redirect if the user is not an admin' do
      p1 = LearningObjective.make

      put :approve, :id => p1.id

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should approve the learning objective' do
      @user.admin = true
      @user.save!

      p1 = LearningObjective.make(:pending => true)
      p1.pending.should == true


      put :approve, :id => p1.id
      p1.reload
      p1.pending.should == false
    end
  end

  context '"GET" edit' do
    it 'should redirect if learning not found' do
      put :edit, :id => 1

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should redirect if the user is not an admin' do
      p1 = LearningObjective.make

      put :edit, :id => p1.id

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should return the specified learning' do
      @user.admin = true
      @user.save!
      
      p1 = LearningObjective.make

      get :edit, :id => p1.id

      assigns[:learning].should == p1
    end
  end

  context '"PUT" update' do
    it 'should redirect if learning not found' do
      put :update, :id => 1

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should redirect if the user is not an admin' do
      p1 = LearningObjective.make

      put :update, :id => p1.id

      response.should be_redirect
      response.should redirect_to(learnings_path)
    end

    it 'should be valid' do
      @user.admin = true
      @user.save!

      p1 = LearningObjective.make

      post :update, :id => p1.id, :learning_objective => { :brief => "" }

      p1.reload
      LearningObjective.count.should == 1
      p1.reload.brief.should_not == ""
      assigns[:learning].brief.should == ""
      assigns[:learning].errors.empty?.should == false
    end

    it 'should update the learning' do
      @user.admin = true
      @user.save!

      p1 = LearningObjective.make

      post :update, :id => p1.id, :learning_objective => { :brief => "testing is good", :discipline => "performance", :category => "responsibility" }

      LearningObjective.count.should == 1
      LearningObjective.first.brief.should == "testing is good"
      LearningObjective.first.discipline.should == "performance"
      LearningObjective.first.category.should == "responsibility"
    end
  end
end