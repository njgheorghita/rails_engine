class TotalRevenueSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  
  attributes :revenue

  def revenue 
    number_with_precision((object["total_revenue"]/100.to_f), precision: 2)
  end


end