module Inkling
  module Parsers
    class NoteParser < BaseParser

      def parse
        notes = []
        xml_doc.xpath("//notes").children.each do |note_node|
          notes << parse_note_node(note_node)
        end

        notes
      end

      def parse_note_node(note_node)
        attrs = note_node.to_hash
        note = Inkling::Note.new
        attrs[:kids].each do |node|
          attr_name = node[:name].gsub("-", "_")
          note.send("#{attr_name}=", parse_node_value(node)) if note.respond_to?("#{attr_name}=")
        end

        note
      end
    end
  end
end
