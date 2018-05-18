require 'spec_helper'

describe ShopsController, :type => :controller do
  describe "ShopsController" do
    it 'make shops list' do
      publisher = Publisher.new.id
      get :index, {publisher_id: publisher}
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to include("the store or book wasn't found. Make sure id's are correct")
      publisher = Publisher.first.id.to_s
      get :index, {publisher_id: publisher}
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to include("Shops")
    end
  end
end