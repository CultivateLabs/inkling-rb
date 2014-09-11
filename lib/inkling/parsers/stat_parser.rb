module Inkling
  module Parsers
    class StatParser < BaseParser
      def parse
        stats = []
        xml_doc.xpath("//stats").children.each do |stat_node|
          stats << parse_stat_node(stat_node)
        end

        stats
      end

      def parse_stat_node(stat_node)
        attrs = stat_node.to_hash
        type = attrs[:kids].find{|kid| kid[:name] == "stat_type"}[:text]
        if type == "quantity_position"
          stat = Inkling::QuantityStat.new
        elsif type == "percentage_position"
          stat = Inkling::PercentageStat.new
        end
        attrs[:kids].each do |node|
          attr_name = node[:name].gsub("-", "_")
          stat.send("#{attr_name}=", parse_node_value(node)) if stat.respond_to?("#{attr_name}=")
        end

        stat
      end

    end
  end
end
