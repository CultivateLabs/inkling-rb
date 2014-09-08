require "spec_helper"

describe Inkling::Parsers::TradeParser do
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
      trade_node = trade_parser.xml_doc.xpath("//trades").children.first
      trade_parser.parse_trade_node(trade_node)
    end

    it "parses a trade node into a trade object" do
      expect(trade.class).to eq(Inkling::Trade)
      expect(trade.id).to eq(967188452)
      expect(trade.membership_id).to eq(14)
      expect(trade.stock_id).to eq(928654638)
      expect(trade.created_at).to eq(Time.parse('2014-09-08T14:39:54-07:00'))
      expect(trade.quantity).to eq(90)
      expect(trade.paid).to eq(-542894)
      expect(trade.reason).to eq(nil)
      expect(trade.starting_price).to eq(6457)
      expect(trade.final_price).to eq(5598)
      expect(trade.login).to eq("admin")
    end
  end
end
