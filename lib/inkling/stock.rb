module Inkling
  class Stock < ApiResource
    def self.attributes
      [:created_at, :eod_price, :id, :price, :price_before_resolution, 
       :refunded, :resolved_at, :slush, :starting_price, :name, 
       :description, :symbol, :closed]
    end
    attr_accessor *attributes  
  end
end