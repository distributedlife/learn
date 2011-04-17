require 'spec_helper'

describe Definitions do
  context 'create' do
    it 'should not be valid without a name' do
      definition = Definitions.new
      definition.description = 'bananas are good for the seoul'
      definition.topic = 'writer'

      definition.valid?.should == false
      definition.name = 'Cardinal Biggles'
      definition.valid?.should == true
    end

    it 'should not be valid without a description' do
      definition = Definitions.new
      definition.name = 'Cardinal Biggles'
      definition.topic = 'writer'

      definition.valid?.should == false
      definition.description = 'bananas are good for the seoul'
      definition.valid?.should == true
    end

    it 'should not be valid without a type' do
      definition = Definitions.new
      definition.name = 'Cardinal Biggles'
      definition.description = 'bananas are good for the seoul'

      definition.valid?.should == false
      definition.topic = 'writer'
      definition.valid?.should == true
    end
  end
end
