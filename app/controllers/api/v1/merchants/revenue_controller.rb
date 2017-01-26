class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: {"revenue" => Merchant.revenue(params[:id])}, serializer: RevenueSerializer
  end

  def index
    render json: {"total_revenue" => Merchant.revenue_by_date(params[:date])}, serializer: TotalRevenueSerializer
  end
end