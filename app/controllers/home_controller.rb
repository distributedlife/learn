class HomeController < ApplicationController
  def search
    @q = params[:q]
    
    if @q.nil? or @q.empty?
       @learning_objectives = LearningObjective::order(:discipline).order(:category).order(:brief).all
    else
       @learning_objectives = LearningObjective::order(:discipline).order(:category).order(:brief).search(@q)
    end

    respond_to do |format|
      format.html
    end
  end
end
