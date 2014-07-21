require "spec_helper"

describe Inkling::Parsers::StockParser do
  let(:stock_parser) do
    Inkling::Parsers::StockParser.new
  end

  describe "#parse_stock_node" do
    let(:stock) do
      xml_doc = Nokogiri::XML.parse(File.read("./spec/support/responses/markets.xml")) do |config|
        config.noblanks
      end
      stock_node = xml_doc.xpath("//stocks").children.first
      stock_parser.parse_stock_node(stock_node)
    end

    it "parses a stock node into a Stock object" do
      expect(stock.class).to eq(Inkling::Stock)
      expect(stock.created_at).to eq(Time.parse("2014-04-15T11:44:14-07:00"))
      expect(stock.eod_price).to eq(14797)
      expect(stock.id).to eq(928654748)
      expect(stock.price).to eq(14797)
      expect(stock.price_before_resolution).to eq(14797)
      expect(stock.refunded).to eq(nil)
      expect(stock.resolved_at).to eq(nil)
      expect(stock.slush).to eq(nil)
      expect(stock.starting_price).to eq(14797)
      expect(stock.name).to eq("AA")
      expect(stock.description).to eq(nil)
      expect(stock.symbol).to eq("AA")
      expect(stock.closed).to eq(true)
    end

  end
end
