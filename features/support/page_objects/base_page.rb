class BasePage
  def initialize session
    @session = session
    @url = '/'
  end

  def visit
    @session.visit @url
  end
end