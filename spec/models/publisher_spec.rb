require 'spec_helper'

describe Publisher do

  describe '#name' do
  
    it 'should validate presence' do
      record = Publisher.new
      record.name = ''
      record.valid?
      record.errors[:name].should include("can't be blank") 
      record.name = "SomeName" 
      record.valid? 
      record.errors[:name].should_not include("can't be blank") 
    end
    
  end
end
