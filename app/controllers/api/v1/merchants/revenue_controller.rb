class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: {"total_revenue" => Merchant.total_merchant_revenue_by_date(params[:date])}
  end

  # def index
  #   render json: {"total_revenue" => Merchant.revenue_by_date(params[:date])}
  # end

  def show
    render json: {"revenue" => Merchant.revenue(params[:id])}, serializer: RevenueSerializer
  end

end
