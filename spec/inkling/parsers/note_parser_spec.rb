require "spec_helper"

describe Inkling::Parsers::NoteParser do
  let(:note_parser) do
    Inkling::Parsers::NoteParser.new(File.read("./spec/support/responses/notes.xml"))
  end

  describe ".parse" do
    it "returns an array of note objects" do
      notes = note_parser.parse
      expect(notes.length).to eq(3)
      expect(notes.first.class).to eq(Inkling::Note)
    end
  end

  describe "#parse_note_node" do
    let(:note) do
      note_node = note_parser.xml_doc.xpath("//notes").children.first
      note_parser.parse_note_node(note_node)
    end

    it "parses a note node into a note object" do
      expect(note.class).to eq(Inkling::Note)
      expect(note.created_at).to eq(Time.parse("2014-09-05T12:44:59-07:00"))
      expect(note.depth).to eq(0)
      expect(note.id).to eq(794590773)
      expect(note.likes_count).to eq(0)
      expect(note.market_id).to eq(852213713)
      expect(note.membership_id).to eq(14)
      expect(note.parent_id).to eq(nil)
      expect(note.updated_at).to eq(Time.parse("2014-09-05T12:44:59-07:00"))
      expect(note.text).to eq("something!")
      expect(note.login).to eq("admin")
    end
  end
end
