class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.total_merchant_revenue_by_date(params[:date])
  end

  def show
    render json: {"revenue" => Merchant.revenue(params[:id])}
  end

end
