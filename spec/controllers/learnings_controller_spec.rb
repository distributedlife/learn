ssigns[:learning_objectives].include?(p2).should == true
    end
  end
  
  describe '"DELETE" destroy' do
    it 'should redirect if learning not found' do
      delete :destroy, :id => 1

      response.should be_redirect
      response.should redirect_to(browse_learnings_path)
    end

    it 'should redirect if the user is not an admin' do
      p1 = LearningObjective.make

      delete :destroy, :id => p1.id

      response.should be_redirect
      response.should redirect_to(browse_learnings_path)
    end
    
    it 'should delete the learning objective' do
      @user.admin = true
      @user.save
      
      other_user = User.make
      p1 = LearningObjective.make(:pending => false)
      p2 = LearningObjective.make(:pending => false)
      
      delete :destroy, :id => p1.id
      
      LearningObjective.where(:id => p1.id).empty?.should == true
      LearningObjective.where(:id => p2.id).empty?.should == false
    end
    
    it 'should delete all user assessments' do
      @user.admin = true
      @user.save
      
      other_user = User.make
      p1 = LearningObjective.make(:pending => false)
      p2 = LearningObjective.make(:pending => false)
      UserAssessments.make(:user_id => @user.id, :learning_objective_id => p1.id)
      UserAssessments.make(:user_id => other_user.id, :learning_objective_id => p1.id)
      UserAssessments.make(:user_id => @user.id, :learning_objective_id => p2.id)
      UserAssessments.make(:user_id => other_user.id, :learning_objective_id => p2.id)
      
      delete :destroy, :id => p1.id
      
      UserAssessments.count.should == 2
      
      UserAssessments.where(:learning_objective_id => p2.id).count.should ==  2
      LearningObjective.where(:id => p1.id).empty?.should == true
      LearningObjective.where(:id => p2.id).empty?.should == false
    end
  end
end