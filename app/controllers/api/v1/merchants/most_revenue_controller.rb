class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: Merchant.top_merchants_by_revenue(params[:quantity])
  end

end