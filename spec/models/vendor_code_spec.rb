require 'spec_helper'

describe VendorCode do

  describe '#book' do
  
    it 'should validate presence' do
      record = VendorCode.new
      record.book = ''
      record.valid?
      record.errors[:book].should include("can't be blank") 
      record.book = Book.new 
      record.valid? 
      record.errors[:book].should_not include("can't be blank") 
    end
    
  end

  describe '#shop' do
  
    it 'should validate presence' do
      record = VendorCode.new
      record.shop = ''
      record.valid?
      record.errors[:shop].should include("can't be blank") 
      record.shop = Shop.new 
      record.valid? 
      record.errors[:shop].should_not include("can't be blank") 
    end
    
  end

  describe '#copies_in_stock' do
  
    it 'should validate greater than 0' do
      record = VendorCode.new
      record.copies_in_stock = -3
      record.valid?
      record.errors[:copies_in_stock].should include("must be greater than or equal to 0") 
      record.copies_in_stock = 5 
      record.valid? 
      record.errors[:copies_in_stock].should_not include("must be greater than or equal to 0") 
    end
    
  end

  describe '#chech_uniq' do
  
    it 'should validate greater nor more than one vendor_code for same shop and book' do
      record = VendorCode.new
      shop = Shop.new
      book = Book.new
      record.shop = shop
      record.book = book
      record.save
      record.errors[:shop_id].should_not include("can't be more than 1 vendor_code for book at specific shop") 
      record_new = VendorCode.new
      record_new.shop = shop
      record_new.book = book
      record_new.save
      record_new.errors[:shop_id].should include("can't be more than 1 vendor_code for book at specific shop") 
    end
    
  end

  describe '#chech_publisher_id' do
  
    it 'should validate publisher_ids for vendor_code and book are equal' do
      record = VendorCode.new
      book = Book.new(publisher_id: 1)
      book.vendor_codes << record
      record.save(:validate => false)
      record.publisher_id = 2
      record.update_attributes(copies: 2)
      record.errors[:publisher_id].should include("publisher_ids for Vendor code and book must be equal") 
      record.publisher_id = 1
      record.update_attributes(copies: 1)
      record.errors[:publisher_id].should_not include("publisher_ids for Vendor code and book must be equal") 
    end
    
  end
  
end