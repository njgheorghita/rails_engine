class Api::V1::Items::MostRevenueController < ApplicationController
  serialization_scope nil

  def index
    render json: Item.most_revenue(params[:quantity]), :each_serializer => ItemsMostRevenueSerializer
  end

end