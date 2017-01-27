class Api::V1::InvoiceItems::QueryController < ApplicationController
  def show
    render json: InvoiceItem.find_by(adjusted_invoice_item_params)
  end

  def index
    render json: InvoiceItem.where(adjusted_invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

  def adjusted_invoice_item_params
    return { "unit_price" => (invoice_item_params["unit_price"].to_f * 100).round(0) } if invoice_item_params["unit_price"]
    invoice_item_params
  end

end