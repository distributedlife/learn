class HomeController < ApplicationController
  def search
    query = params[:q]
    
    if query.nil? or query.empty?
       @learning_objectives = LearningObjective.order(:brief).all
    else
       @learning_objectives = LearningObjective.order(:brief).search(query)
    end
    
    respond_to do |format|
      format.html
    end
  end
end
