Given /^an unapproved account exists$/ do
  user = User.make(:approved => false)

  add(:pending_user, user)
end

And /^I create an account for "([^"]*)"$/ do |email|
  password = "password"

  fill_in('user_email', :with => email)
  fill_in('user_password', :with => password)
  fill_in('user_password_confirmation', :with => password)
  click_on("create_account")

  add(:user, User.where(:email => email).first)
end

And /^I am a new, authenticated user$/ do
  email = 'user@testing.com'
  password = 'password'

  And %{I have one user "#{email}" with password "#{password}"}
  And %{I login with "#{email}" and "#{password}"}
end

And /^I am a new, authenticated, admin user$/ do
  email = 'admin@testing.com'
  password = 'password'

  And %{I have one user "#{email}" with password "#{password}"}

  get(:user).admin = true
  get(:user).save!
  
  And %{I login with "#{email}" and "#{password}"}
end

And /^I have one\s+user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  user = User.new(:email => email, :password => password, :password_confirmation => password, :approved => true)
  user.save!
  
  add(:user, user)
end

And /^I login with "([^\"]*)" and "([^\"]*)"$/ do |email, password|
  And %{I go to the "user login" page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Login"}

  add(:email, email)
  add(:password, password)

  add(:user, User.where(:email => email).first)
end

And /^I log in as "([^"]*)"$/ do |email|
  And %{I login with "#{email}" and "#{get(:password)}"}
end

And /^I log in using a password of "([^"]*)"$/ do |password|
  And %{I login with "#{get(:email)}" and "#{password}"}
end

And /^I change my email address to "([^"]*)"$/ do |email|
  on_page :EditAccountPage, Capybara.current_session do |page|
    page.change_email_address email, get(:password)
  end
end

And /^I change my password to "([^"]*)"$/ do |password|
  on_page :EditAccountPage, Capybara.current_session do |page|
    page.change_password get(:password), password
  end
end

And /^I cancel my account$/ do
  on_page :EditAccountPage, Capybara.current_session do |page|
    page.cancel_account
  end
end

And /^my account should be deleted$/ do
  User.count.should == 0
end