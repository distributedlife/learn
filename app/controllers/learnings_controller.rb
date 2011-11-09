class LearningsController < ApplicationController
  before_filter :authenticate_user!, :except => ['show', 'search', 'browse']

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
    redirect_to browse_learnings_path and return if @q.blank?

    @page = params[:page]
    @page ||= 1
    @page = @page.to_i

    limit = Rails.application.config.page_size
    offset = (@page - 1) * limit
    @nextpage = search_learnings_path(:q => @q, :page => @page + 1)
    
    
    @disciplines = LearningObjective.trim_invalid_disciplines(@q.split(' '))
    @categories = LearningObjective.trim_invalid_categories(@q.split(' '))

    #don't use search query if it is still within our filter
    query_to_search_for = adjust_query_if_it_was_a_filter(@q, @disciplines, @categories)

    @learning_objectives = LearningObjective::order(:discipline).order(:category).order(:brief).limit(limit).offset(offset).search(query_to_search_for, @disciplines, @categories, @show_pending)
    @result_count = LearningObjective::order(:discipline).order(:category).order(:brief).search(query_to_search_for, @disciplines, @categories, @show_pending).count
    @pages =  @result_count / limit
    @pages = @pages + 1 if LearningObjective.count % limit != 0
  end

  def pending_assessments
    @learning_objectives = LearningObjective::pending_for_user current_user.id
  end

  def pending_approvals
    @learning_objectives = LearningObjective.pending
  end

  def browse
    @page = params[:page]
    @page ||= 1
    @page = @page.to_i

    limit = Rails.application.config.page_size
    offset = (@page - 1) * limit
    @nextpage = browse_learnings_path(:page => @page + 1)
    
    @learning_objectives = LearningObjective::order(:discipline).order(:category).order(:brief).limit(limit).offset(offset).all
    @result_count = LearningObjective.count
    @pages = @result_count / limit
    @pages = @pages + 1 if LearningObjective.count % limit != 0

    render :template => "learnings/search"
  end
  
  def destroy
    return error_redirect_to t('notice.not-found'), learnings_path unless LearningObjective::exists? params[:id]

    @learning = LearningObjective.find params[:id]
    return error_redirect_to t('notice.not-authorised'), learnings_path unless current_user.admin?

    @learning.user_assessments.each {|ua| ua.delete}
    @learning.delete
    
    redirect_to :back
  end

  protected
  def adjust_query_if_it_was_a_filter(query, disciplines, categories)
    adjusted_query_string = ""

    query.split(' ').each do |term|
      next if disciplines.include? term or categories.include? term
      
      adjusted_query_string = "#{adjusted_query_string} #{term}"
    end

    adjusted_query_string
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