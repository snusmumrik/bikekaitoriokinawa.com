class BikesController < ApplicationController
  # GET /prices
  # GET /prices.json
  def index
    if params[:maker_id] && params[:engine_id]
      @bikes = Bike.joins(:maker, :engine).where(["makers.id = ? AND engines.id = ?", params[:maker_id], params[:engine_id]]).select(:id, :name)
      render json: @bikes
    else
      redirect_to root_path
    end
  end
end
