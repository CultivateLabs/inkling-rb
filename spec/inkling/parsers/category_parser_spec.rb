require "spec_helper"

describe Inkling::Parsers::CategoryParser do
  let(:category_parser) do
    Inkling::Parsers::CategoryParser.new(File.read("./spec/support/responses/categories.xml"))
  end

  describe ".parse" do
    it "returns an array of Category objects" do
      categories = category_parser.parse
      expect(categories.length).to eq(10)
      expect(categories.first.class).to eq(Inkling::Category)
    end
  end

  describe "#parse_category_node" do
    let(:category) do
      category_node = category_parser.xml_doc.xpath("//categories").children.first
      category_parser.parse_category_node(category_node)
    end

    it "parses a category node into a Category object" do
      expect(category.class).to eq(Inkling::Category)
      expect(category.id).to eq(1)
      expect(category.name).to eq("Entertainment")
      expect(category.description).to eq("Detailed description")
    end
  end
end
