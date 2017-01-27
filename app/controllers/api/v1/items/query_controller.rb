class Api::V1::Items::QueryController < ApplicationController
  def show
    render json: Item.find_by(adjusted_item_params)
  end

  def index
    render json: Item.where(item_params)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

  def adjusted_item_params
    return { "unit_price" => (item_params["unit_price"].to_f * 100).round(0) } if item_params["unit_price"]
    item_params
  end
end
