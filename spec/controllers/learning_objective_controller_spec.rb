require 'spec_helper'

describe LearningObjectiveController do
  describe "POST 'update'" do
    before do
      request.env["HTTP_REFERER"] = "http://distributedlife.com"
      @lo = LearningObjective.make(:pending => true)
    end

    context 'when learning objective id exists' do
      it 'should be a redirect' do
        post(:update, {:id => @lo.id})
        
        response.should be_redirect
      end

      it 'should not update the pending attribute if it is not supplied' do
        post(:update, {:id => @lo.id})
       
        @lo.reload
        @lo.pending.should == true;
      end

      it 'should update the pending attribute if it is supplied' do
        post(:update, {:id => @lo.id, :pending => false})

        @lo.reload
        @lo.pending.should == false;
      end

      it 'should redirect back with undo message to revert change' do
        post(:update, {:id => @lo.id, :pending => false})

        response.should redirect_to :back
        flash[:undo].should ~ /^Success!/
      end
    end

    context 'when resource supplied does not exist' do
      it 'should redirect with error message when redirect supplied' do
        post(:update, {:id => 0})

        response.should redirect_to :back
        flash[:failure].should == "Unable to complete as the requested learning objective could not be found."
      end
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

    it 'should return the list of disciplines in alphabetical order' do
      get(:search, {:q => ''})

      assigns(:discipline_values).count.should be 9
      assigns(:discipline_values)[0].should == 'automation'
      assigns(:discipline_values)[1].should == 'behaviour & functionality'
      assigns(:discipline_values)[2].should == 'domain knowledge'
      assigns(:discipline_values)[3].should == 'fundamentals'
      assigns(:discipline_values)[4].should == 'infrastructure & integration'
      assigns(:discipline_values)[5].should == 'performance'
      assigns(:discipline_values)[6].should == 'preparation & planning'
      assigns(:discipline_values)[7].should == 'security'
      assigns(:discipline_values)[8].should == 'user interaction'
    end

    it 'should return the list of categories in alphabetical order' do
      get(:search, {:q => ''})

      assigns(:category_values).count.should be 5
      assigns(:category_values)[0].should == 'artefact'
      assigns(:category_values)[1].should == 'concept'
      assigns(:category_values)[2].should == 'lens'
      assigns(:category_values)[3].should == 'responsibility'
      assigns(:category_values)[4].should == 'technique'
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

      assigns(:q).empty?.should be true
      assigns(:disciplines).should == ['automation']
    end

    it 'should map query to a category when supplied' do
      get(:search, {:q => 'concept'})

      assigns(:learning_objectives).count.should be 1
      assigns(:learning_objectives)[0].brief.should == 'the quick brown fox jumps over the lazy dog'

      assigns(:q).empty?.should be true
      assigns(:categories).should == ['concept']
    end

    it 'should filter results when discipline is provided' do
      get(:search, {:disciplines => 'automation'})

      assigns(:learning_objectives).count.should be 2
      assigns(:learning_objectives)[0].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[1].brief.should == 'aba quick brown fox jumps over the lazy zog'
    end

    it 'should filter results when category is provided' do
      get(:search, {:categories => 'concept'})

      assigns(:learning_objectives).count.should be 1
      assigns(:learning_objectives)[0].brief.should == 'the quick brown fox jumps over the lazy dog'
    end

    it 'should allow multiple discipline filter items' do
      get(:search, {:disciplines => ['automation', 'fundamentals']})

      assigns(:learning_objectives).count.should be 3
      assigns(:learning_objectives)[0].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[1].brief.should == 'aba quick brown fox jumps over the lazy zog'
      assigns(:learning_objectives)[2].brief.should == 'the quick brown fox jumps over the lazy dog'
    end

    it 'should allow multiple category filter items' do
      get(:search, {:categories => ['concept', 'lens']})

      assigns(:learning_objectives).count.should be 2
      assigns(:learning_objectives)[0].brief.should == 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[1].brief.should == 'the quick brown fox jumps over the lazy dog'
    end

    it 'should not include search results that are excluded by the discipline filter' do
      get(:search, {:q => 'quick', :disciplines => 'user interaction'})

      assigns(:learning_objectives).count.should be 0
    end

    it 'should not include search results that are excluded by the category filter' do
      get(:search, {:q => 'quick', :categories => 'lens'})

      assigns(:learning_objectives).count.should be 0
    end

    it 'should allow discipline, category and search query at the same time' do
      get(:search, {:q => 'aaaaa', :disciplines => 'user interaction', :categories => 'artefact'})

      assigns(:learning_objectives).count.should be 1
      assigns(:learning_objectives)[0].brief.should == 'aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm'
    end

    it 'should preserve filters and search terms across queries' do
      get(:search, {:q => 'automation', :disciplines => 'user interaction', :categories => 'artefact'})
      assigns(:q).empty?.should be true
      assigns(:disciplines).count.should be 2
      assigns(:categories).count.should be 1

      get(:search, {:q => 'lens', :disciplines => assigns(:disciplines), :categories => assigns(:categories)})
      assigns(:q).empty?.should be true
      assigns(:disciplines).count.should be 2
      assigns(:categories).count.should be 2

      get(:search, {:q => 'spaceship', :disciplines => assigns(:disciplines), :categories => assigns(:categories)})
      assigns(:q).should == 'spaceship'
      assigns(:disciplines).count.should be 2
      assigns(:categories).count.should be 2
    end

    it 'should ignore invalid discipline values and revert to show all if need be' do
      get(:search, {:disciplines => 'banana'})
      assigns(:learning_objectives).count.should be 5
      assigns(:disciplines).count.should be 0
    end

    it 'should ignore invalid discipline values' do
      get(:search, {:disciplines => ['banana', 'user interaction']})
      assigns(:learning_objectives).count.should be 1
      assigns(:disciplines)[0].should == 'user interaction'
    end

    it 'should ignore invalid category values and revert to show all if need be' do
      get(:search, {:categories => 'banana'})
      assigns(:learning_objectives).count.should be 5
      assigns(:categories).count.should be 0
    end

    it 'should ignore invalid category values' do
      get(:search, {:categories => ['banana', 'lens']})
      assigns(:learning_objectives).count.should be 1
      assigns(:categories)[0].should == 'lens'
    end

    it 'should handle to_param arrays' do
      get(:search, {:disciplines => LearningObjective::DISCIPLINES.to_param})

      assigns(:learning_objectives).count.should be 5
      assigns(:disciplines).count.should be 9
    end

    it 'should unescape strings' do
      get(:search, {:disciplines => ['user%20interaction'].to_param})
      assigns(:learning_objectives).count.should be 1
      assigns(:disciplines)[0].should == 'user interaction'


      get(:search, {:disciplines => 'user%20interaction'})
      assigns(:learning_objectives).count.should be 1
      assigns(:disciplines)[0].should == 'user interaction'
    end

    it 'should handle set operations, to_param and unescaping strings' do
      get(:search, {:disciplines => CGI::escape((LearningObjective::DISCIPLINES - ['automation']).to_param)})
      assigns(:learning_objectives).count.should be 3
      assigns(:disciplines).count.should be 8
    end

    it 'should not include pending items by default' do
      create_pending_learning_objective('zomg this is pending', 'fundamentals', 'concept')

      get(:search)
      assigns(:learning_objectives).count.should be 5
      assigns(:show_pending).should be false
    end

    it 'should include pending items when requested' do
      create_pending_learning_objective('zomg this is pending', 'fundamentals', 'concept')

      get(:search, {:show_pending => true})
      assigns(:learning_objectives).count.should be 6
      assigns(:show_pending).should be true
    end

    it 'should map a search query of pending to the pending enabled flag' do
      create_pending_learning_objective('zomg this is pending', 'fundamentals', 'concept')

      get(:search, {:q => 'pending'})
      assigns(:learning_objectives).count.should be 6
      assigns(:show_pending).should be true
      assigns(:q).empty?.should be true

      get(:search, {:q => 'show pending'})
      assigns(:learning_objectives).count.should be 6
      assigns(:show_pending).should be true
      assigns(:q).empty?.should be true
    end

    it 'should map a search query of hide pending to the pending hidden flag' do
      create_pending_learning_objective('zomg this is pending', 'fundamentals', 'concept')

      get(:search, {:q => 'hide pending'})
      assigns(:learning_objectives).count.should be 5
      assigns(:show_pending).should be false
      assigns(:q).empty?.should be true
    end
  end
end
