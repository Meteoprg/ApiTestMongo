require 'spec_helper'

describe Book do

  describe '#publisher' do
  
    it 'should validate presence' do
      record = Book.new
      record.publisher = ''
      record.valid?
      record.errors[:publisher].should include("can't be blank") 
      record.publisher = Publisher.new 
      record.valid? 
      record.errors[:publisher].should_not include("can't be blank") 
    end
    
  end

  describe '#title' do
  
    it 'should validate presence' do
      record = Book.new
      record.title = ''
      record.valid?
      record.errors[:title].should include("can't be blank") 
      record.title = "SomeTitle" 
      record.valid? 
      record.errors[:title].should_not include("can't be blank") 
    end
    
  end
  
end