class InfoController < ApplicationController
  def about
  end

  def index
    if user_signed_in?
      redirect_to user_index_path
    end
  end

  def how_assessments_work
  end

  def an_example
  end

  def how_disciplines_work
  end

  def how_categories_work
  end
end
