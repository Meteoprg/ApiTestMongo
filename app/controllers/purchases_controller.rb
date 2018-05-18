class PurchasesController < ApplicationController

  def create
    render json: Purchase.for_params(params)
  end

end