class Item < ApplicationRecord

  def self.random
    Item.order("RANDOM()").first
  end

end
