module Inkling
  module Parsers
    class TradeParser < BaseParser
      def parse
        trades = []
        xml_doc.xpath("//trades").children.each do |trade_node|
          trade = parse_trade_node(trade_node)
          if !trade.nil?
            trades << trade
          end
        end

        trades
      end

      def parse_trade_node(trade_node)
        attrs = trade_node.to_hash
        trade = nil
        if !attrs[:kids].nil? #trade xml can have an empty array if there are no trades
          trade = Inkling::Trade.new
          attrs[:kids].each do |node|
            if node[:name] == "stock"
              trade.stock_id = parse_node_value(node[:kids].first)
            elsif node[:name] == "membership"
              trade.membership_id = parse_node_value(node[:kids].first)
            else
              attr_name = node[:name].gsub("-", "_")
              trade.send("#{attr_name}=", parse_node_value(node)) if trade.respond_to?("#{attr_name}=")
            end
          end
        end

        trade
      end
    end
  end
end
