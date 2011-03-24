require 'cgi'

class HomeController < ApplicationController
  def search
    @q = ''
    @disciplines = []
    @categories = []

    @q = params[:q] unless params[:q].nil?


    #as we are using to_param we need to decode the url_encoded strings; if they are encoded
    params[:disciplines] = params[:disciplines].each_with_index {|unused, i| CGI::unescape(params[:disciplines][i])} if params[:disciplines].kind_of?(Array)
    params[:categories] = params[:categories].each_with_index {|unused, i| CGI::unescape(params[:categories][i])} if params[:categories].kind_of?(Array)
    params[:disciplines] = CGI::unescape(params[:disciplines]) if params[:disciplines].kind_of?(String)
    params[:categories] = CGI::unescape(params[:categories]) if params[:categories].kind_of?(String)


    #turn our supplied filters into an array if they are not already one
    #we split on / as we need to cater for rails to_param method
    params[:disciplines] = params[:disciplines].split('/') unless params[:disciplines].kind_of?(Array) or params[:disciplines].nil?
    params[:categories] = params[:categories].split('/') unless params[:categories].kind_of?(Array) or params[:categories].nil?


    #add supplied disciplines and categories to our arrays
    @disciplines = @disciplines | params[:disciplines] unless params[:disciplines].nil? or params[:disciplines].empty?
    @categories = @categories | params[:categories] unless params[:categories].nil? or params[:categories].empty?


    #add query string to discipline and category
    @disciplines = @disciplines | [@q] unless @q.empty?
    @categories = @categories | [@q] unless @q.empty?


    #remove all invalid disciplines or categories
    unless @disciplines.empty?
      @disciplines = LearningObjective.trim_invalid_disciplines(@disciplines)
    end

    unless @categories.empty?
      @categories = LearningObjective.trim_invalid_categories(@categories)
    end


    #don't use search query if it is still within our filter
    if (@disciplines & [@q] == [@q]) or (@categories & [@q] == [@q])
      @q = ""
    end


    @learning_objectives = LearningObjective::order(:discipline).order(:category).order(:brief).search(@q, @disciplines, @categories)


#    @disciplines = LearningObjective::DISCIPLINES.sort if @disciplines.empty?
#    @categories = LearningObjective::CATEGORIES.sort if @categories.empty?
    @discipline_values = LearningObjective::DISCIPLINES.sort
    @category_values = LearningObjective::CATEGORIES.sort

    respond_to do |format|
      format.html
    end
  end
end