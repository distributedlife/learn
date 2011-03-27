class LearningObjectiveController < ApplicationController
  ERROR = "Unable to complete as the requested learning objective could not be found."
  UNDO = "Changes saved. Click here to undo."

  def update
    begin
      @lo = LearningObjective.find(params[:id])
    
      @lo.pending = params[:pending] unless params[:pending].nil?
    
      @lo.save!

      redirect_to :back, :flash => {:undo => UNDO}
    rescue
      redirect_to :back, :flash => {:error => ERROR} if @lo.nil?
    end
  end
end
