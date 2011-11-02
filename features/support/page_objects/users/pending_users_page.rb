module PendingUsersPage
  def is_get?
    true
  end

  def url sut
    "/users/pending"
  end

  def is_current_page?
    @session.has_content?("Pending User Accounts").should == true
  end

  def approve_user id
    @session.click_on("approve_#{id}")
  end
end
