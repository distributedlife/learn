class HomeController < ApplicationController
  def index
    @learning_objectives = LearningObjective.order(:brief).all

    respond_to do |format|
      format.html 
    end
  end
end
