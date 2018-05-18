require 'spec_helper'
describe PurchasesController, :type => :controller do
  describe "Purchases " do
    it 'make Purchase' do
      vc = VendorCode.new(copies_in_stock: 2)
      vc.save(:validation => false)
      shop = vc.shop_id
      book = vc.book_id
      post :create, :params => {shop_id: shop, book_id: book, copies: 1}
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to include("the store or book wasn't found. Make sure id's are correct")
      vc = VendorCode.gt(copies_in_stock: 0).first
      vc.save(:validation => false)
      shop = vc.shop_id
      book = vc.book_id
      post :create, :params => {shop_id: shop, book_id: book, copies: 1}
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to include("id")
    end
  end
end