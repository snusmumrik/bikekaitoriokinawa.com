class MetersController < ApplicationController
  # GET /prices
  # GET /prices.json
  def index
    if params[:bike_id]
      @meters = Price.where(["bike_id = ?", params[:bike_id]]).group(:year).select(:year).sort_by { |m| m.year.to_i }
      render json: @meters
    else
      redirect_to root_path
    end
  end
end
