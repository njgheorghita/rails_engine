class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    if params[:date]
      render json: {"revenue" => Merchant.find(params[:id]).individual_revenue_by_date(params[:date])}, serializer: RevenueSerializer
    else
      render json: {"revenue" => Merchant.revenue(params[:id])}, serializer: RevenueSerializer
    end
  end

  def index
    render json: {"total_revenue" => Merchant.revenue_by_date(params[:date])}, serializer: TotalRevenueSerializer
  end
end
