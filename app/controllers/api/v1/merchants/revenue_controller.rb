class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: {"revenue" => Merchant.revenue(params[:id])}
  end

end