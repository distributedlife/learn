require 'spec_helper'

describe HomeController do
  describe "GET 'search'" do
    before(:each) do
      create_learning_objective('the quick brown fox jumps over the lazy dog')
      create_learning_objective('aaaaa bbbbb ccccc ddddd eeeee fffff ggggg')
      create_learning_objective('aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm')
    end

    it 'should be successful' do
      get 'search'
      response.should be_success
    end

    it 'should return all rows when query is not provided' do      
      get 'search'

      assigns(:learning_objectives).count.should be 3
     end

    it 'should return all rows when query is blank' do
      get(:search, {:q => ''})

      assigns(:learning_objectives).count.should be 3
    end

    it 'should filter results when query is provided' do
      get(:search, {:q => 'dog'})

      assigns(:learning_objectives).count.should be 1
      assigns(:learning_objectives).first.brief = 'the quick brown fox jumps over the lazy dog'
    end

    it 'should order unfiltered results alphabetically' do
      get(:search, {:q => ''})

      assigns(:learning_objectives)[0].brief = 'the quick brown fox jumps over the lazy dog'
      assigns(:learning_objectives)[1].brief = 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[2].brief = 'aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm'
    end

    it 'should order filtered results alphabetically' do
      get(:search, {:q => 'aaa'})

      assigns(:learning_objectives)[0].brief = 'aaaaa bbbbb ccccc ddddd eeeee fffff ggggg'
      assigns(:learning_objectives)[1].brief = 'aaaaa hhhhh iiiii jjjjj kkkkk lllll mmmmm'
    end
  end
end
