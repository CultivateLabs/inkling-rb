module Inkling
  class Price < ApiResource

    def self.attributes
      [:created_at, :value, :stock_id]
    end
    attr_accessor *attributes

  end
end
