module Inkling
  module Parsers
    class BaseParser
      attr_accessor :xml_doc
      def initialize(string = nil)
        if !string.nil?
          self.xml_doc = Nokogiri::XML.parse(string) do |config|
            config.noblanks
          end
        end
      end

      def parse_node_value(node)
        value = node[:text]

        return nil if value == "" || value.nil?

        if node[:attr].is_a?(Array)
          type_attr = node[:attr].detect{|type_attr| type_attr[:name] == "type" }
          return value if type_attr.nil?

          value = case type_attr[:text]
          when "datetime"
            Time.parse(value)
          when "integer"
            value.to_i
          when "float"            
            value.to_f
          when "boolean"
            value == "true"
          else
            value
          end
        end

        value
      end
    end
  end
end