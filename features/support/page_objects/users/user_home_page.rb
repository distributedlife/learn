module UserHomePage
  def is_get?
    true
  end

  def url sut
    "/users"
  end

  def is_current_page?
    @session.has_content?("Testing").should == true
  end
end
