module LearningObjectiveSearchHelper
  def search_url(text, query, disciplines, categories, show_pending)
    link_to("#{text}", "/learning_objective/search?q=#{query}&disciplines=#{CGI::escape(disciplines.to_param)}&categories=#{CGI::escape(categories.to_param)}&show_pending=#{show_pending}")
  end
end
