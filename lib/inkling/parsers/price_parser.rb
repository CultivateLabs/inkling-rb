module Inkling
  module Parsers
    class PriceParser < BaseParser
      def parse
        prices = []
        xml_doc.xpath("//prices").children.each do |price_node|
          prices << parse_price_node(price_node)
        end

        prices
      end

      def parse_price_node(price_node)
        attrs = price_node.to_hash
        price = Inkling::Price.new
        attrs[:kids].each do |node|
          if node[:name] == "stock"
            price.stock_id = parse_node_value(node[:kids].first)
          else
            attr_name = node[:name].gsub("-", "_")
            price.send("#{attr_name}=", parse_node_value(node)) if price.respond_to?("#{attr_name}=")
          end
        end

        price
      end
    end
  end
end