require 'spec_helper'

describe LearningObjective do
  context 'single object' do
    before(:each) do
      @lo = LearningObjective.new
    end

    it 'brief should be invalid without a brief' do
      @lo.valid?().should be false
      @lo.brief = "something"
      @lo.valid?().should be true
    end

    it 'brief should not be greater than 500 characters' do
      @lo.valid?().should be false
      @lo.brief = "a" * (500 + 1)
      @lo.valid?().should be false
    end
  end

  context 'search' do
    before(:each) do
      create_learning_objective('the quick brown fox jumps over the lazy dog')
      create_learning_objective('aaaaa bbbbb ccccc ddddd eeeee fffff ggggg')
      create_learning_objective('aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm')
    end

    it 'should wildcard match on brief at the start of strings' do
      results = LearningObjective.search('the q')

      LearningObjective.all.count.should be 3

      results.count.should be 1
      results.each do |lo|
        lo.brief.should == 'the quick brown fox jumps over the lazy dog'
      end
    end

    it 'should wildcard match on brief at the end of strings' do
      results = LearningObjective.search('zy dog')

      results.count.should be 1
      results.each do |lo|
        lo.brief.should == 'the quick brown fox jumps over the lazy dog'
      end
    end

    it 'should wildcard match in the middle of strings' do
      results = LearningObjective.search('cc dd')

      results.count.should be 1
      results.each do |lo|
        lo.brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      end
    end

    it 'should not return results that do not match' do
      results = LearningObjective.search('banana')

      results.count.should be 0
    end

    it 'should return all results that match' do
      results = LearningObjective.search('aa')

      results.count.should be 2
      results[0].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      results[1].brief.should == 'aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm'
    end
  end
end
