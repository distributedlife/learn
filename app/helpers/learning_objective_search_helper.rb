module LearningObjectiveSearchHelper
  def search_url text, query, disciplines, categories, show_pending
    link_to "#{text}", "/learning_objective/search?q=#{query}&disciplines=#{CGI::escape(disciplines.to_param)}&categories=#{CGI::escape(categories.to_param)}&show_pending=#{show_pending}"
  end

  def valid_dom_id(text)
    text.gsub(/ & /,"__").gsub(/ /, "_")
  end

  def from_valid_dom_id(text)
    text.gsub(/__/," & ").gsub(/_/, " ")
  end
end
