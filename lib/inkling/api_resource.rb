module Inkling
  class ApiResource
    include AttributeInitialization

    attr_accessor :client

    def initialize(attrs = {})
      initialize_attributes(attrs)
    end

    def self.list(c, params = {}, obj = nil)
      endpoint = obj.nil? ? collection_endpoint : "#{obj_endpoint(obj)}/#{collection_endpoint}"
      response = c.make_request(:get, endpoint, params)

      if response
        Object.const_get("Inkling::Parsers::#{self.to_s.split("::").last}Parser").new(response).parse
      else
        false
      end
    end

    def self.resource_name
      self.to_s.split("::").last.to_s.underscore
    end

    def self.collection_endpoint
      if resource_name[-1] == 'y'
        "#{resource_name[0..-2]}ies"
      else
        "#{resource_name}s"
      end
    end

    def self.obj_endpoint(obj)
      "#{obj.class.resource_name}s/#{obj.id}"
    end

    def member_endpoint
      "#{self.class.resource_name}s/#{self.id}"
    end

  end
end
