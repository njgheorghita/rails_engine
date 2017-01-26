class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: {"revenue" => Merchant.revenue(params[:id])}
  end

  def index
    render json: {"revenue" => Merchant.revenue_by_date(params[:date])}
  end
end