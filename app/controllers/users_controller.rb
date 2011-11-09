class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:flash_messages]

  def flash_messages
    messages = {}
    messages["success"] = session[:success] unless session[:success].nil?
    messages["error"] = session[:failure] unless session[:failure].nil?
    messages["error"] = session[:error] unless session[:error].nil?
    messages["warning"] = session[:warning] unless session[:warning].nil?
    messages["info"] = session[:notice] unless session[:notice].nil?
    messages["info"] = session[:info] unless session[:info].nil?
    session.delete :success
    session.delete :warning
    session.delete :notice
    session.delete :failure
    session.delete :error
    session.delete :info

    respond_to do |format|
      format.json { render :json => messages}
    end
  end

  def index
  end
end
