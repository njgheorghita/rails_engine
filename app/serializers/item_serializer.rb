class ItemSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    number_with_precision((object["unit_price"]/100.to_f), precision: 2)
  end
end
