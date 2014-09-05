module Inkling
  class Note < ApiResource

    def self.attributes
      [:created_at, :depth, :id, :likes_count, :market_id, :membership_id, :parent_id, :updated_at, :text, :login]
    end
    attr_accessor *attributes

  end
end
