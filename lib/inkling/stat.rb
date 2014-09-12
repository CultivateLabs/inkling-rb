module Inkling
  class Stat < ApiResource

    def self.attributes
      [:stock_id, :stock_name, :stat_type, :login, :membership_id, :percent, :predictions]
    end
    attr_accessor *attributes

    def self.resource_name
      "dashboard_stat"
    end

  end
end
