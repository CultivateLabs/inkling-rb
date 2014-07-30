module Inkling
  class ApiResource
    include AttributeInitialization

    attr_accessor :client

    def initialize(c = nil, attrs = {})
      self.client = c
      initialize_attributes(attrs)
    end

    def self.list(c, obj=nil, params = {})
      endpoint = obj.nil? ? collection_endpoint : "#{obj_endpoint(obj)}/#{collection_endpoint}"
      response = c.make_request(:get, endpoint, params)
      Object.const_get("Inkling::Parsers::#{self.to_s.split("::").last}Parser").new(response).parse
    end

    def self.resource_name
      self.to_s.split("::").last.to_s.underscore
    end

    def self.collection_endpoint
      "#{resource_name}s"
    end

    def self.obj_endpoint(obj)
      "#{obj.class.resource_name}s/#{obj.id}"
    end

    def member_endpoint
      "#{self.class.resource_name}s/#{self.id}"
    end

  end
end