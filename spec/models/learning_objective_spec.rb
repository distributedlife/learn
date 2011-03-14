require 'spec_helper'

describe LearningObjective do
  before(:each) do
    @lo = LearningObjective.new
  end

  it 'brief should be invalid without a brief' do
    @lo.valid?().should be false
    @lo.brief = "something"
    @lo.valid?().should be true
  end

  it 'brief should not be greater than 500 characters' do
    @lo.valid?().should be false
    @lo.brief = "a" * (500 + 1)
    @lo.valid?().should be false
  end
end
