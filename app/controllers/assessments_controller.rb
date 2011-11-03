class AssessmentsController < ApplicationController
  def update
    return error_redirect_to t('notice.not-found'), learnings_path unless LearningObjective::exists? params[:learning_id]
    return error_redirect_to t('notice.not-found'), learnings_path unless UserAssessments::exists? params[:id]

    assessment = UserAssessments.find params[:id]
    return error_redirect_to t('notice.not-found'), learnings_path if assessment.user_id != current_user.id
    return error_redirect_to t('notice.not-found'), learnings_path if assessment.learning_objective_id != params[:learning_id].to_i

    assessment.update_attributes(params[:user_assessment])
    if assessment.invalid?
      error_redirect_to t('notice.invalid-assessment'), :back
    else
      assessment.save
      success_redirect_to t('notice.assessment-updated'), :back
    end
  end
end
