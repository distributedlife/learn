class HomeController < ApplicationController
  def search
    @q = params[:q]
    
    if @q.nil? or @q.empty?
       @learning_objectives = LearningObjective::order(:brief).all
    else
       @learning_objectives = LearningObjective::order(:brief).search(@q)
    end
    
    respond_to do |format|
      format.html
    end
  end
end
