class LearningsController < ApplicationController
  before_filter :authenticate_user!, :except => ['show', 'search']

  def new
    @learning = LearningObjective.new
  end

  def create
    @learning = LearningObjective.new(params[:learning_objective])
    render :template => "learnings/new" and return if @learning.invalid?

    @learning.save

    success_redirect_to t('notice.learning-created'), learning_path(@learning.id)
  end

  def show
    return error_redirect_to t('notice.not-found'), learnings_path unless LearningObjective::exists? params[:id]

    @learning = LearningObjective.find params[:id]

    if user_signed_in?
      @assessment = current_user.get_assessment @learning.id
      @assessment ||= UserAssessments.new(:user_id => current_user.id, :learning_objective_id => @learning.id, :awareness => 'not assessed', :guidance => 'not assessed')
      @assessment.save
    end
  end

  def approve
    return error_redirect_to t('notice.not-found'), learnings_path unless LearningObjective::exists? params[:id]

    @learning = LearningObjective.find params[:id]
    return error_redirect_to t('notice.not-authorised'), learnings_path unless current_user.admin?

    
    @learning.approve!
    
    redirect_to :back
  end

  def edit
    return error_redirect_to t('notice.not-found'), learnings_path unless LearningObjective::exists? params[:id]

    @learning = LearningObjective.find params[:id]
    return error_redirect_to t('notice.not-authorised'), learnings_path unless current_user.admin?
  end

  def update
    return error_redirect_to t('notice.not-found'), learnings_path unless LearningObjective::exists? params[:id]

    @learning = LearningObjective.find params[:id]
    return error_redirect_to t('notice.not-authorised'), learnings_path unless current_user.admin?

    @learning.update_attributes(params[:learning_objective])
    render :template => "learnings/edit" and return if @learning.invalid?

    @learning.save
    success_redirect_to t('notice.learning-updated'), learning_path(@learning.id)
  end

  def search
    @q = ''
    @show_pending = true

    @q = params[:q] unless params[:q].nil?


    #get disciplines
    @disciplines = get_array_from_query_params(params[:disciplines])
    @disciplines = add_querystring_to_array(@disciplines, @q)
    @disciplines = LearningObjective.trim_invalid_disciplines(@disciplines)


    #get categories
    @categories = get_array_from_query_params(params[:categories])
    @categories = add_querystring_to_array(@categories, @q)
    @categories = LearningObjective.trim_invalid_categories(@categories)


    #don't use search query if it is still within our filter
    query_to_search_for = adjust_query_if_it_was_a_filter(@q, @disciplines, @categories)


    @learning_objectives = LearningObjective::order(:discipline).order(:category).order(:brief).search(query_to_search_for, @disciplines, @categories, @show_pending)
  end

  def pending_assessments
    @learning_objectives = LearningObjective::pending_for_user current_user.id
  end

  def pending_approvals
    @learning_objectives = LearningObjective.pending
  end
  
  def adjust_query_if_it_was_a_filter(query, disciplines, categories)
    if disciplines.include? query or categories.include? query
      ""
    else
      query
    end
  end


  def add_querystring_to_array(array, querystring)
    return array if querystring.empty?

    array << querystring
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