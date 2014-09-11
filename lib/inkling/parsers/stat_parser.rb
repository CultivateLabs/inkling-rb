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

        underscore_descendants = Inkling::Stat.descendants.map{|s| s.to_s.split("::").last.underscore}
        raise "Invalid Stat Type" unless underscore_descendants.include?(type)
        stat = Inkling::Stat.descendants[underscore_descendants.index(type)].new

        attrs[:kids].each do |node|
          attr_name = node[:name].gsub("-", "_")
          stat.send("#{attr_name}=", parse_node_value(node)) if stat.respond_to?("#{attr_name}=")
        end

        stat
      end

    end
  end
end
