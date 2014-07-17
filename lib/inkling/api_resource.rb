module Inkling
  class ApiResource
    include AttributeInitialization

    attr_accessor :client

    def initialize(c, attrs = {})
      self.client = c
      initialize_attributes(attrs)
    end

    def self.list(c, params = {})
      c.make_request(:get, collection_endpoint, params)
    end

    def self.resource_name
      self.to_s.split("::").last.to_s.underscore
    end

    def self.collection_endpoint
      "#{resource_name}s"
    end

    def member_endpoint
      "#{self.class.resource_name}s/#{self.id}"
    end

  end
end