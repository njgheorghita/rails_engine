class InvoiceItemSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  def unit_price 
    number_with_precision((object["unit_price"]/100.to_f), precision: 2)
  end
end
