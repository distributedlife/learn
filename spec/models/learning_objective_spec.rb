require 'spec_helper'

describe LearningObjective do
  context 'LearningObjective' do
    context 'brief' do
      it 'should be invalid without a brief' do
        @lo = LearningObjective.new
        @lo.discipline = "automation"
        @lo.category = "concept"

        @lo.valid?().should be false
        @lo.errors[:brief].should == ["that can't be blank"]
        @lo.brief = "something"
        @lo.valid?().should be true
        @lo.errors.empty?.should be true
      end

      it 'should be invalid if brief is greater than 500 characters' do
        @lo = LearningObjective.new
        @lo.discipline = "automation"
        @lo.category = "concept"

        @lo.valid?().should be false
        @lo.brief = "a" * (500 + 1)
        @lo.valid?().should be false
        @lo.errors[:brief].should == ["that has to be shorter"]
      end

      it 'should be invalid if brief exists within same discipline' do
        @lo = LearningObjective.new
        @lo.brief = 'elephantasaurus'
        @lo.discipline = "automation"
        @lo.category = "concept"
        @lo.valid?().should be true
        @lo.save

        @lo2 = LearningObjective.new
        @lo2.brief = 'elephantasaurus'
        @lo2.discipline = "automation"
        @lo2.category = "concept"
        @lo2.valid?().should be false
        @lo2.errors[:brief].should == ["that has not been taken"]
      end
    end

    context 'discipline' do
      it 'should be invalid without a discipline' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.category = "concept"

        @lo.valid?().should be false
        @lo.errors[:discipline].should == ["from the following"]
        @lo.discipline = "automation"
        @lo.valid?().should be true
        @lo.errors.empty?.should be true
      end

      it 'should be invalid if discipline is not in allowed list' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.category = "concept"


        @lo.valid?().should be false

        LearningObjective::DISCIPLINES.each do |allowed_type|
          @lo.discipline = allowed_type
          @lo.valid?().should be true
          @lo.errors.empty?.should be true
        end

        @lo.discipline = 'banana'
        @lo.valid?().should be false
        @lo.errors[:discipline].should == ["from the following"]
      end
    end

    context 'category' do
      it 'should be invalid without a type' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.discipline = "automation"

        @lo.valid?().should be false
        @lo.errors[:category].should == ["from the following"]
        @lo.category = "concept"
        @lo.valid?().should be true
        @lo.errors.empty?.should be true
      end

      it 'should be invalid if type is not in allowed list' do
        @lo = LearningObjective.new
        @lo.brief = "space monkey"
        @lo.discipline = "automation"


        @lo.valid?().should be false
        LearningObjective::CATEGORIES.each do |allowed_type|
          @lo.category = allowed_type
          @lo.valid?().should be true
          @lo.errors.empty?.should be true
        end

        @lo.category = 'banana'
        @lo.valid?().should be false
        @lo.errors[:category].should == ["from the following"]
      end
    end

    context 'pending' do
      it 'should be true by default' do
        @lo = LearningObjective.new
        @lo.pending.should be true
      end
    end
  end

  context 'search' do
    before do
      create_learning_objective('the quick brown fox jumps over the lazy dog', 'automation', 'concept')
      create_learning_objective('aaaaa bbbbb ccccc ddddd eeeee fffff ggggg', 'fundamentals', 'lens')
      create_learning_objective('aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm', 'user interaction', 'artefact')
    end

    it 'should wildcard match on brief at the start of strings' do
      results = LearningObjective.search('the q')

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

    it 'should not match on discipline' do
      results = LearningObjective.search('automation')

      results.count.should be 0
    end

    it 'should not match on category' do
      results = LearningObjective.search('concept')

      results.count.should be 0
    end

    it 'should support filtering on discipline' do
      results = LearningObjective.search('', 'automation', '')

      results.count.should be 1
      results[0].brief.should == 'the quick brown fox jumps over the lazy dog'
      results[0].discipline.should == 'automation'
    end

    it 'should support filtering on category' do
      results = LearningObjective.search('', '', 'concept')

      results.count.should be 1
      results[0].brief.should == 'the quick brown fox jumps over the lazy dog'
      results[0].category.should == 'concept'
    end

    it 'should support multiple filters on discipline' do
      results = LearningObjective.search('', ['automation', 'user interaction'], '')

      results.count.should be 2
      results[0].brief.should == 'the quick brown fox jumps over the lazy dog'
      results[0].discipline.should == 'automation'
      results[1].brief.should == 'aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm'
      results[1].discipline.should == 'user interaction'
    end

    it 'should support multiple filters on category' do
      results = LearningObjective.search('', '', ['concept', 'lens'])

      results.count.should be 2
      results[0].brief.should == 'the quick brown fox jumps over the lazy dog'
      results[0].discipline.should == 'automation'
      results[1].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      results[1].discipline.should == 'fundamentals'
    end

    it 'should support both filtering and searching at the same time' do
      results = LearningObjective.search('a', ['automation', 'user interaction', 'fundamentals'], ['concept', 'lens', 'artefact'])

      results.count.should be 3
      results[0].brief.should == 'the quick brown fox jumps over the lazy dog'
      results[0].discipline.should == 'automation'
      results[1].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      results[1].discipline.should == 'fundamentals'
      results[2].brief.should == 'aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm'
      results[2].discipline.should == 'user interaction'
    end

    it 'should exclude pending by default' do
      create_pending_learning_objective('I are pending!', 'user interaction', 'artefact')

      results = LearningObjective.search('', '', '')
      results.count.should be 3

      results = LearningObjective.search('', '', '', false)
      results.count.should be 3
    end

    it 'should include pending when requested' do
      create_pending_learning_objective('I are pending!', 'user interaction', 'artefact')

      results = LearningObjective.search('', nil, nil, true)
      results.count.should be 4
    end
  end

  context 'trim_invalid_disciplines' do
    it 'should accept a single discipline' do
      disciplines = LearningObjective.trim_invalid_disciplines('automation')
      disciplines.count.should be 1
      disciplines[0].should == 'automation'

      disciplines = LearningObjective.trim_invalid_disciplines('banana')
      disciplines.empty?. should be true
    end

    it 'should accept an array of disciplines' do
      disciplines = LearningObjective.trim_invalid_disciplines(['automation', 'banana', 'user interaction'])

      disciplines.count.should be 2
      disciplines[0].should == 'automation'
      disciplines[1].should == 'user interaction'
    end
  end

  context 'trim_invalid_categories' do
    it 'should accept a single category' do
      categories = LearningObjective.trim_invalid_categories('lens')
      categories.count.should be 1
      categories[0].should == 'lens'

      categories = LearningObjective.trim_invalid_categories('banana')
      categories.empty?. should be true
    end

    it 'should accept an array of categories' do
      categories = LearningObjective.trim_invalid_categories(['lens', 'banana', 'concept'])

      categories.count.should be 2
      categories[0].should == 'concept'
      categories[1].should == 'lens'
    end
  end

  describe 'exists?' do
    it 'should return true if the idiom exists' do
      LearningObjective::exists?(LearningObjective.make.id).should == true
    end

    it 'should return false if the idiom does not exist' do
      LearningObjective::exists?(100).should == false
    end
  end

  describe 'approve!' do
    it 'should set pending to false' do
      l = LearningObjective.make(:pending => true)

      l.approve!
      l.pending.should == false
      
      l.approve!
      l.pending.should == false
    end
  end
end
