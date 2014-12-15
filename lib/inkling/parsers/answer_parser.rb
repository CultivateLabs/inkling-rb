module Inkling
  module Parsers
    class AnswerParser < BaseParser

      def parse
        answers = []
        xml_doc.xpath("//answers").children.each do |answer_node|
          answers << parse_answer_node(answer_node)
        end

        answers
      end

      def parse_answer_node(answer_node)
        attrs = answer_node.to_hash
        answer = Inkling::Answer.new
        
        attrs[:kids].each do |node|
          attr_name = node[:name].gsub("-", "_")
          answer.send("#{attr_name}=", parse_node_value(node)) if answer.respond_to?("#{attr_name}=")
        end

        answer
      end
    end
  end
end