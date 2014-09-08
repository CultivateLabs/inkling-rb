module Inkling
  class Trade < ApiResource

    def self.attributes
      [:created_at, :membership_id, :stock_id, :id, :quantity, :paid, :reason, :starting_price, :final_price, :login]
    end
    attr_accessor *attributes

  end
end
