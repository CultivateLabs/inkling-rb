require "spec_helper"

describe Inkling::Parsers::tradeParser do
  let(:trade_parser) do
    Inkling::Parsers::TradeParser.new(File.read("./spec/support/responses/trades.xml"))
  end

  describe ".parse" do
    it "returns an array of trade objects" do
      trades = trade_parser.parse
      expect(trades.length).to eq(3)
      expect(trades.first.class).to eq(Inkling::Trade)
    end
  end

  describe "#parse_trade_node" do
    let(:trade) do
      trade_node = trade_parser.xml_doc.xpath("//notes").children.first
      trade_parser.parse_trade_node(trade_node)
    end

    it "parses a trade node into a trade object" do
      expect(trade.class).to eq(Inkling::Trade)
      expect(trade.parent_id).to eq(nil)
    end
  end
end
