require "spec_helper"

describe Inkling::Parsers::PriceParser do
  let(:price_parser) do
    Inkling::Parsers::PriceParser.new(File.read("./spec/support/responses/prices.xml"))
  end

  describe ".parse" do
    it "returns an array of Price objects" do
      prices = price_parser.parse
      expect(prices.length).to eq(30)
      expect(prices.first.class).to eq(Inkling::Price)
    end
  end

  describe "#parse_price_node" do
    let(:price) do
      price_node = price_parser.xml_doc.xpath("//prices").children.first
      price_parser.parse_price_node(price_node)
    end

    it "parses a price node into a Price object" do
      expect(price.class).to eq(Inkling::Price)
      expect(price.id).to eq(1)
      expect(price.created_at).to eq(Time.parse("2014-04-15T11:48:12-07:00"))
      expect(price.value).to eq(10770)
      expect(price.stock_id).to eq(928654754)
    end
  end
end
