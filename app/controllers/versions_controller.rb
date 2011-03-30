class VersionsController < ApplicationController
  FAILURE = "Could not make change. The record probably has changed since you made your change."

  def revert
    begin
      @version = Version.find(params[:id])

      raise unless @version.next.nil?

      if @version.reify
        @version.reify.save!
      else
        @version.item.destroy
      end

      if (!params[:redo])
        link = self.class.helpers.link_to('Click here if you want to redo.', revert_version_path(@version.next, :redo => 'true'), :method => :post)
      else
        link = self.class.helpers.link_to('Click here if you want to redo.', revert_version_path(@version.id, :redo => 'false'), :method => :post)
      end

      redirect_to :back, :flash => {:success => "Succesfully reverted your change. #{link}"}
    rescue
      redirect_to :back, :flash => {:failure => FAILURE}
    end
  end
end
