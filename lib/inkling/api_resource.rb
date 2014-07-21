module Inkling
  class ApiResource
    include AttributeInitialization

    attr_accessor :client

    def initialize(c = nil, attrs = {})
      self.client = c
      initialize_attributes(attrs)
    end

    def self.list(c, params = {})
      response = c.make_request(:get, collection_endpoint, params)
      Object.const_get("Inkling::Parsers::#{self.to_s.split("::").last}Parser").new(response).parse
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