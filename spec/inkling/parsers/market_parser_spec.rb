require "spec_helper"

describe Inkling::Parsers::MarketParser do
  let(:market_parser) do
    Inkling::Parsers::MarketParser.new(File.read("./spec/support/responses/markets.xml"))
  end

  describe ".parse" do
    it "returns an array of Market objects" do
      markets = market_parser.parse
      expect(markets.length).to eq(30)
      expect(markets.first.class).to eq(Inkling::Market)
    end
  end

  describe "#parse_market_node" do
    let(:market) do
      market_node = market_parser.xml_doc.xpath("//markets").children.first
      market_parser.parse_market_node(market_node)
    end

    it "parses a market node into a Market object" do
      expect(market.class).to eq(Inkling::Market)
      expect(market.type).to eq("futures")
      expect(market.created_at).to eq(Time.parse("2014-04-15T11:41:30-07:00"))
      expect(market.ends_at).to eq(Time.parse("2014-04-30T11:41:00-07:00"))
      expect(market.exclusive).to eq(false)
      expect(market.id).to eq(852213725)
      expect(market.notes_count).to eq(0)
      expect(market.opinion).to eq(false)
      expect(market.resolved).to eq(false)
      expect(market.resolved_at).to eq(nil)
      expect(market.scale).to eq(10000.0)
      expect(market.slush).to eq(nil)
      expect(market.starts_at).to eq(nil)
      expect(market.trades_count).to eq(0)
      expect(market.updated_at).to eq(Time.parse("2014-07-18T07:57:17-07:00"))
      expect(market.name).to eq("What number will each of these be?")
      expect(market.description).to eq(nil)
      expect(market.closed).to eq(true)
      expect(market.membership_id).to eq(14)
      expect(market.category_id).to eq(12)
    end

    it "parses the stocks into an array" do
      expect(market.stocks.length).to eq(8)
      expect(market.stocks.first.class).to eq(Inkling::Stock)
    end

    it "parses the tags into an array" do
      expect(market.tags.length).to eq(2)
      expect(market.tags.first.class).to eq(Inkling::Tag)
    end
  end
end
