require 'spec_helper'

describe LearningObjective do
  context 'LearningObjective' do
    context 'brief' do
      it 'should be invalid without a brief' do
        @lo = LearningObjective.new
        @lo.discipline = "automation"
        @lo.category = "concept"

        @lo.valid?().should be false
        @lo.brief = "something"
        @lo.valid?().should be true
      end

      it 'should be invalid if brief is greater than 500 characters' do
        @lo = LearningObjective.new
        @lo.discipline = "automation"
        @lo.category = "concept"

        @lo.valid?().should be false
        @lo.brief = "a" * (500 + 1)
        @lo.valid?().should be false
      end
    end

    context 'discipline' do
      it 'should be invalid without a discipline' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.category = "concept"

        @lo.valid?().should be false
        @lo.discipline = "automation"
        @lo.valid?().should be true
      end

      it 'should be invalid if discipline is not in allowed list' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.category = "concept"


        @lo.valid?().should be false
        LearningObjective::DISCIPLINES.each do |allowed_type|
          @lo.discipline = allowed_type
          @lo.valid?().should be true
        end

        @lo.discipline = 'banana'
        @lo.valid?().should be false
      end
    end

    context 'category' do
      it 'should be invalid without a type' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.discipline = "automation"

        @lo.valid?().should be false
        @lo.category = "concept"
        @lo.valid?().should be true
      end

      it 'should be invalid if type is not in allowed list' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.discipline = "automation"


        @lo.valid?().should be false
        LearningObjective::CATEGORIES.each do |allowed_type|
          @lo.category = allowed_type
          @lo.valid?().should be true
        end

        @lo.category = 'banana'
        @lo.valid?().should be false
      end
    end
  end

  context 'search' do
    before(:each) do
      create_learning_objective('the quick brown fox jumps over the lazy dog', 'automation', 'concept')
      create_learning_objective('aaaaa bbbbb ccccc ddddd eeeee fffff ggggg', 'fundamentals', 'lens')
      create_learning_objective('aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm', 'user interaction', 'artefact')
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

    it 'should match on category' do
      results = LearningObjective.search('concept')

      results.count.should be 1
      results[0].brief.should == 'the quick brown fox jumps over the lazy dog'
      results[0].category.should == 'concept'
    end
  end
end
