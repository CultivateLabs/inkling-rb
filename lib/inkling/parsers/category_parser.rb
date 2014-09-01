module Inkling
  module Parsers
    class CategoryParser < BaseParser
      def parse_category_node(category_node)
        attrs = category_node.to_hash
        category = Inkling::category.new
        attrs[:kids].each do |node|
          attr_name = node[:name].gsub("-", "_")
          category.send("#{attr_name}=", parse_node_value(node)) if category.respond_to?("#{attr_name}=")
        end

        category
      end
    end
  end
end
