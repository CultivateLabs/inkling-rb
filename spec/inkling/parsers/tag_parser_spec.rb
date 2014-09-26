require "spec_helper"

describe Inkling::Parsers::TagParser do
  let(:tag_parser) do
    Inkling::Parsers::TagParser.new(File.read("./spec/support/responses/tags.xml"))
  end

  describe ".parse" do
    it "returns an array of Tag objects" do
      tags = tag_parser.parse

      expect(tags.length).to eq(8)
      expect(tags.first.class).to eq(Inkling::Tag)
    end
  end

  describe "#parse_tag_node" do
    let(:tag) do
      tag_node = tag_parser.xml_doc.xpath("//tags").children.first
      tag_parser.parse_tag_node(tag_node)
    end

    it "parses a tag not into a Tag object" do
      expect(tag.class).to eq(Inkling::Tag)
      expect(tag.id).to eq(1)
      expect(tag.name).to eq("Uno")
    end
  end
end