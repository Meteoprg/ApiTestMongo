class ShopsController < ApplicationController

  def index 
    render json: Shop.for_publisher(params[:publisher_id])
  end

end

