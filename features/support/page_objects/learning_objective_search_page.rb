module SearchLearningObjectivePage
  def url *params
    "/"
  end

  def is_current_page?
    @session.has_content?("show pending") && @session.has_content?("automation")
  end

  def show_pending
    @session.click_on 'show pending'
  end

  def hide_pending
    @session.click_on 'hide pending'
  end

  def search_for search_term
    @session.fill_in('q', :with => search_term)
    @session.click_on('Search')
  end
end