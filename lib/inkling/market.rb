module Inkling
  class Market < ApiResource
    attr_accessor :stocks

    def self.attributes
      [:created_at, :ends_at, :exclusive, :id, :notes_count, :opinion,
       :resolved, :resolved_at, :scale, :slush, :starts_at, :trades, :tags,
       :updated_at, :name, :description, :closed, :membership_id, :type, :trades_count, :category_id]
    end
    attr_accessor *attributes

    def stocks
      @stocks ||= []
    end

    def tags
      @tags ||= []
    end
  end
end
