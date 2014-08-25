module Inkling
  module AttributeInitialization
    
    def initialize_attributes(attributes = {})
      attributes.each do |key, val|
        if respond_to?("#{key}=")
          val = Time.parse(val) if key.to_s[-3, 3] == "_at" && !val.is_a?(Time)
          val = val.to_i if key.to_s == "id" && !val.nil?
          send("#{key}=", val)
        end
      end
    end

    def to_hash
      {}.tap do |hsh|
        self.class.attributes.each do |key|
          hsh[key] = send(key) unless key.to_s=="id" && send(key).nil?
        end
      end
    end

  end
end