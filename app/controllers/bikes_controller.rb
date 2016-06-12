class BikesController < ApplicationController
  # GET /prices
  # GET /prices.json
  def index

    if params[:bike_id] && params[:year] && params[:meter_id]
      @bikes = Bike.where(["maker_id = ? AND engine_id = ?", params[:maker_id], params[:engine_id]]).all
    end

    respond_to do |format|
      format.json @bikes
    end
  end
end
