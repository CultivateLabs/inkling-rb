module Inkling
  class Price < ApiResource

    def self.attributes
      [:created_at, :value, :stock_id]
    end
    attr_accessor *attributes

    def self.collection_endpoint
      "#{resource_name}s.xml"
    end
  end
end