require 'spec_helper'

describe Purchase do

  describe '#vendor_code' do
  
    it 'should validate presence' do
      record = Purchase.new
      record.vendor_code = ''
      record.valid?
      record.errors[:vendor_code].should include("can't be blank") 
      record.vendor_code = VendorCode.new 
      record.valid? 
      record.errors[:vendor_code].should_not include("can't be blank") 
    end
    
  end

  describe '#copies' do
  
    it 'should validate greater than 0' do
      record = Purchase.new
      record.copies = -3
      record.valid?
      record.errors[:copies].should include("must be greater than or equal to 0") 
      record.copies = 5 
      record.valid? 
      record.errors[:copies].should_not include("must be greater than or equal to 0") 
    end
    
  end

  describe '#check_count' do
  
    it 'should validate copies count not more than copies in stock' do
      record = Purchase.new
      record.copies = 5
      record.vendor_code = VendorCode.new(copies_in_stock: 2)
      record.valid? 
      record.errors[:count].should include("count for purchse can't be more than count in stock") 
      record.copies = 5
      record.vendor_code = VendorCode.new(copies_in_stock: 10)
      record.errors[:title].should_not include("count for purchse can't be more than count in stock") 
    end
    
  end
  
end