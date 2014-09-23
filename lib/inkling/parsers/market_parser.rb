module Inkling
  module Parsers
    class MarketParser < BaseParser
      def parse
        markets = []
        xml_doc.xpath("//markets").children.each do |market_node|
          markets << parse_market_node(market_node)
        end

        markets
      end

      def parse_market_node(market_node)
        attrs = market_node.to_hash
        market = Inkling::Market.new
        market.type = attrs[:name]
        attrs[:kids].each do |node|
          if node[:name] == "stocks"
            stock_parser = Inkling::Parsers::StockParser.new
            node[:kids].each do |stock_node|
              market.stocks << stock_parser.parse_stock_node(stock_node)
            end
          elsif node[:name] == "membership"
            market.membership_id = parse_node_value(node[:kids].first)
          elsif node[:name] == "tags"
            tag_parser = Inkling::Parsers::TagParser.new
            node[:kids].each do |tag_node|
              market.tags << tag_parser.parse_tag_node(tag_node)
            end
          else
            attr_name = node[:name].gsub("-", "_")
            market.send("#{attr_name}=", parse_node_value(node)) if market.respond_to?("#{attr_name}=")
          end
        end

        market
      end
    end
  end
end