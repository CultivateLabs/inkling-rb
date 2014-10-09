module Inkling
  class Price < ApiResource

    def self.attributes
      [:id, :created_at, :value, :stock_id]
    end
    attr_accessor *attributes

  end
end
