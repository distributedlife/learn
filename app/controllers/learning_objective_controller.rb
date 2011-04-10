include LearningObjectiveSearchHelper

class LearningObjectiveController < ApplicationController
  FAILURE = "Unable to complete as the requested learning objective could not be found."
  SUCCESS = "Success!"
  
  def search
    @q = ''
    @show_pending = false

    @q = params[:q] unless params[:q].nil?
    @show_pending = true if params[:show_pending] == "true" or params[:show_pending] == true


    #get disciplines
    @disciplines = get_array_from_query_params(params[:disciplines])
    @disciplines = add_querystring_to_array(@disciplines, @q)
    @disciplines = LearningObjective.trim_invalid_disciplines(@disciplines) 

    
    #get categories
    @categories = get_array_from_query_params(params[:categories])
    @categories = add_querystring_to_array(@categories, @q)
    @categories = LearningObjective.trim_invalid_categories(@categories) 


    #don't use search query if it is still within our filter
    @q = adjust_query_if_it_was_a_filter(@q, @disciplines, @categories)


    #map query to pending, show pending or hide pending
    if @q == 'pending' or @q == 'show pending'
      @q = ""
      @show_pending = true
    end
    if @q == 'hide pending'
      @q = ""
      @show_pending = false
    end


    @learning_objectives = LearningObjective::order(:discipline).order(:category).order(:brief).search(@q, @disciplines, @categories, @show_pending)


    @discipline_values = LearningObjective::DISCIPLINES.sort
    @category_values = LearningObjective::CATEGORIES.sort

    respond_to do |format|
      format.html
    end
  end


  def update
    begin
      @lo = LearningObjective.find(params[:id])
      @lo.pending = params[:pending] unless params[:pending].nil?
      @lo.save!

      link = self.class.helpers.link_to('Click here to undo.', revert_version_path(@lo.versions.scoped.last), :method => :post)
      redirect_to :back, :flash => {:success => "#{SUCCESS} #{link}"}
    rescue
      redirect_to :back, :flash => {:failure => FAILURE} if @lo.nil?
    end
  end


  def ajax_update
    begin
      @lo = LearningObjective.find(params[:id])
      @lo.pending = params[:pending] unless params[:pending].nil?
      @lo.save!

      @link = self.class.helpers.link_to('Click here to undo.', revert_version_path(@lo.versions.scoped.last), :method => :post)

#      respond_to do |format|
#        format.js {render :layout=>false}
#      end
    rescue
      redirect_to :back, :flash => {:failure => FAILURE} if @lo.nil?
    end
  end


  private
  def adjust_query_if_it_was_a_filter(query, disciplines, categories)
    if (disciplines & [query] == [query]) or (categories & [query] == [query])
      ""
    else
      query
    end
  end


  def add_querystring_to_array(array, querystring)
    array = array | [querystring] unless querystring.empty?
    array
  end


  def get_array_from_query_params(array)
    if array.nil? or array.empty?
      return []
    end
    
    #as we are using to_param we need to decode the url_encoded strings; if they are encoded
    array = array.each_with_index {|unused, i| CGI::unescape(array[i])} if array.kind_of?(Array)
    array = CGI::unescape(array) if array.kind_of?(String)


    #turn our supplied filters into an array if they are not already one
    #we split on / as we need to cater for rails to_param method
    array = array.split('/') unless array.kind_of?(Array) 

    
    array
  end
end
