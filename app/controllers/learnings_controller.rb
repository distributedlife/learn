class LearningsController < ApplicationController
  before_filter :authenticate_user!, :except => ['show']

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
end
