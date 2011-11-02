module PendingAccountPage
  def is_get?
    true
  end

  def url sut
    "/authentications/pending"
  end

  def is_current_page?
    @session.has_content?("You're account has been registered but we haven't approved it yet. You'll get an email when it is approved.").should == true
  end
end
