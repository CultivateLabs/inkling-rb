module Inkling
  module Parsers
    class StockParser < BaseParser
      def parse_stock_node(stock_node)
        attrs = stock_node.to_hash
        stock = Inkling::Stock.new
        attrs[:kids].each do |node|
          attr_name = node[:name].gsub("-", "_")
          stock.send("#{attr_name}=", parse_node_value(node)) if stock.respond_to?("#{attr_name}=")
        end

        stock
      end
    end
  end
end