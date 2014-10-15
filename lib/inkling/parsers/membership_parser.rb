module Inkling
  module Parsers
    class MembershipParser < BaseParser
      def parse
        memberships = []
        xml_doc.xpath("//memberships").children.each do |membership_node|
          memberships << parse_membership_node(membership_node)
        end

        memberships
      end

      def parse_membership_node(membership_node)
        attrs = membership_node.to_hash
        membership = Inkling::Membership.new
        attrs[:kids].each do |node|
          if node[:name] == "user"
            node[:kids].each do |unode|
              attr_name = unode[:name].gsub("-", "_")
              membership.send("#{attr_name}=", parse_node_value(unode)) if (membership.respond_to?("#{attr_name}=") && attr_name != 'id' )
            end
          else
            attr_name = node[:name].gsub("-", "_")
            membership.send("#{attr_name}=", parse_node_value(node)) if membership.respond_to?("#{attr_name}=")
          end
        end

        membership
      end
    end
  end
end
