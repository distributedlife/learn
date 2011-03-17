require 'spec_helper'

describe LearningObjective do
  context 'LearningObjective' do
    it 'should be invalid without a brief' do
      @lo = LearningObjective.new
      @lo.discipline = "a value"
      
      @lo.valid?().should be false
      @lo.brief = "something"
      @lo.valid?().should be true
    end

    it 'should be invalid if brief is greater than 500 characters' do
      @lo = LearningObjective.new
      @lo.discipline = "a value"

      @lo.valid?().should be false
      @lo.brief = "a" * (500 + 1)
      @lo.valid?().should be false
    end

    it 'should be invalid without a discipline' do
      @lo = LearningObjective.new
      @lo.brief = "space monkey"

      @lo.valid?().should be false
      @lo.discipline = "something"
      @lo.valid?().should be true
    end

    it 'should be invalid if discipline is greater than 50 characters' do
      @lo = LearningObjective.new
      @lo.brief = "space monkey"

      @lo.valid?().should be false
      @lo.discipline = "a" * (50 + 1)
      @lo.valid?().should be false
    end
  end

  context 'search' do
    before(:each) do
      create_learning_objective('the quick brown fox jumps over the lazy dog', 'automation')
      create_learning_objective('aaaaa bbbbb ccccc ddddd eeeee fffff ggggg', 'fundamentals')
      create_learning_objective('aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm', 'user interactioj')
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

    it 'should match on discipline' do
      results = LearningObjective.search('automation')

      results.count.should be 1
      results[0].brief.should == 'the quick brown fox jumps over the lazy dog'
      results[0].discipline.should == 'automation'
    end
  end
end
