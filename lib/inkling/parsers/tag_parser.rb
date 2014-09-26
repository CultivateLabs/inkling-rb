module Inkling
  module Parsers
    class TagParser < BaseParser
      
      def parse
        tags = []
        xml_doc.xpath("//tags").children.each do |tag_node|
          tags << parse_tag_node(tag_node)
        end

        tags
      end

      def parse_tag_node(tag_node)
        attrs = tag_node.to_hash

        tag = Inkling::Tag.new
        attrs[:kids].each do |node|
          attr_name = node[:name]
          tag.send("#{attr_name}=", parse_node_value(node)) if tag.respond_to?("#{attr_name}=")
        end

        tag
      end
    end
  end
end