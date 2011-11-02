require 'spec_helper'

describe UsersController do
  context 'index' do
    before(:each) do
      @user = User.make
      sign_in :user, @user
    end

    it 'should return success' do
      get :index
      
      response.should be_success
    end
  end

  context 'flash_messages' do
    before(:each) do
      @user = User.make
      sign_in :user, @user

      request.env["HTTP_REFERER"] = "http://whereiwasbefore.com"
    end

    it 'should delete session messages when read' do
      session[:warning] = "message"

      get :flash_messages

      session[:warning].nil?.should == true
    end

    it 'should return session messages when set' do
      session[:warning] = "message"

      get :flash_messages, :format => :json

      JSON.parse(response.body)["warning"].should == "message"
    end
  end
end
