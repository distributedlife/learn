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

    it 'should create an assessment for the user if one does not exist' do
      p1 = LearningObjective.make
      UserAssessments.count.should == 0

      get :show, :id => p1.id

      assigns[:learning].should == p1
      UserAssessments.count.should == 1
      UserAssessments.first.user_id = @user.id
      UserAssessments.first.learning_objective_id.should == p1.id
      UserAssessments.first.awareness.should == 'not assessed'
      UserAssessments.first.guidance.should == 'not assessed'
    end

    it 'should not create an assessment if the user is not logged in' do
      sign_out :user

      p1 = LearningObjective.make
      UserAssessments.count.should == 0

      get :show, :id => p1.id

      assigns[:learning].should == p1
      UserAssessments.count.should == 0
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

  describe "GET 'search'" do
    before do
      create_learning_objective('the quick brown fox jumps over the lazy dog', 'fundamentals', 'concept')
      create_learning_objective('aba quick brown fox jumps over the lazy zog', 'automation', 'responsibility')
      create_learning_objective('aaaaa bbbbb ccccc ddddd eeeee fffff ggggg', 'automation', 'lens')
      create_learning_objective('aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm', 'user interaction', 'artefact')
      create_learning_objective('zztop automation sauce', 'domain knowledge', 'technique')
    end

    it 'should be successful' do
      get 'search'
      response.should be_success
    end

    it 'should return all rows when query is not provided' do
      get 'search'

      assigns(:learning_objectives).count.should be 5
     end

    it 'should return all rows when query is blank' do
      get(:search, {:q => ''})

      assigns(:learning_objectives).count.should be 5
    end

    it 'should filter results when query is provided' do
      get(:search, {:q => 'dog'})

      assigns(:learning_objectives).count.should be 1
      assigns(:learning_objectives).first.brief.should == 'the quick brown fox jumps over the lazy dog'
    end

    it 'should order unfiltered results alphabetically by discipline then category then brief' do
      get(:search, {:q => ''})

      assigns(:learning_objectives)[0].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[1].brief.should == 'aba quick brown fox jumps over the lazy zog'
      assigns(:learning_objectives)[2].brief.should == 'zztop automation sauce'
      assigns(:learning_objectives)[3].brief.should == 'the quick brown fox jumps over the lazy dog'
      assigns(:learning_objectives)[4].brief.should == 'aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm'
    end

    it 'should order filtered results alphabetically by discipline then category then brief' do
      get(:search, {:q => 'automation'})

      assigns(:learning_objectives)[0].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[1].brief.should == 'aba quick brown fox jumps over the lazy zog'
    end

    it 'should map query to a discipline when supplied' do
      get(:search, {:q => 'automation'})

      assigns(:learning_objectives).count.should be 2
      assigns(:learning_objectives)[0].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[1].brief.should == 'aba quick brown fox jumps over the lazy zog'
    end

    it 'should map query to a category when supplied' do
      get(:search, {:q => 'concept'})

      assigns(:learning_objectives).count.should be 1
      assigns(:learning_objectives)[0].brief.should == 'the quick brown fox jumps over the lazy dog'
    end
  end
end