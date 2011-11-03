require 'spec_helper'

describe UserAssessments do
  describe 'to be valid' do
    it 'should only support specific awarness values' do
      a = UserAssessments.new(:user_id => 1, :learning_objective_id => 1, :guidance => 'not assessed')
      a.valid?.should_not == true

      UserAssessments::AWARENESS.each do |value|
        a.awareness = value
        a.valid?.should == true
        a.errors.empty?.should == true
      end

      a.awareness = 'banana'
      a.valid?.should == false
    end

    it 'should only support specific guidance values' do
      a = UserAssessments.new(:user_id => 1, :learning_objective_id => 1, :awareness => 'not assessed')
      a.valid?.should_not == true

      UserAssessments::GUIDANCE.each do |value|
        a.guidance = value
        a.valid?.should == true
        a.errors.empty?.should == true
      end

      a.guidance = 'banana'
      a.valid?.should == false
    end
  end

  describe 'exists?' do
    it 'should return true if the idiom exists' do
      UserAssessments::exists?(UserAssessments.make.id).should == true
    end

    it 'should return false if the idiom does not exist' do
      UserAssessments::exists?(100).should == false
    end
  end
end
