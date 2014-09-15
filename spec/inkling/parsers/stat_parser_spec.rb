require "spec_helper"

describe Inkling::Parsers::StatParser do
  let(:stat_parser) do
    Inkling::Parsers::StatParser.new(File.read("./spec/support/responses/stats.xml"))
  end

  let(:stat_parser_empty) do
    Inkling::Parsers::StatParser.new(File.read("./spec/support/responses/stats_empty.xml"))
  end

  describe ".parse" do
    it "returns an array of stat objects" do
      stats = stat_parser.parse
      expect(stats.length).to eq(8)
      expect(stats.first.class).to eq(Inkling::QuantityStat)
    end

    it "returns an empty array when there is an empty trade" do
      stats = stat_parser_empty.parse
      expect(stats.length).to eq(0)
    end
  end

  describe "#parse_stat_node" do
    let(:quantity_stat) do
      stat_node = stat_parser.xml_doc.xpath("//stats").children.first
      stat_parser.parse_stat_node(stat_node)
    end

    let(:percentage_stat) do
      stat_node = stat_parser.xml_doc.xpath("//stats").children[1]
      stat_parser.parse_stat_node(stat_node)
    end

    it "parses a stat node into a stat object" do
      expect(quantity_stat.class).to eq(Inkling::QuantityStat)
      expect(quantity_stat.stock_id).to eq(20)
      expect(quantity_stat.stock_name).to eq('huge_balance_trading_stock_1')
      expect(quantity_stat.stat_type).to eq('quantity_stat')
      expect(quantity_stat.login).to eq("admin")
      expect(quantity_stat.membership_id).to eq(14)
      expect(quantity_stat.percent).to eq(100.0)
      expect(quantity_stat.predictions).to eq(2)
    end

    it "parses a stat node into a stat object" do
      expect(percentage_stat.class).to eq(Inkling::PercentageStat)
      expect(percentage_stat.stock_id).to eq(20)
      expect(percentage_stat.stock_name).to eq('huge_balance_trading_stock_1')
      expect(percentage_stat.stat_type).to eq('percentage_stat')
      expect(percentage_stat.login).to eq("admin")
      expect(percentage_stat.membership_id).to eq(14)
      expect(percentage_stat.percent).to eq(52.07)
      expect(percentage_stat.predictions).to eq(2)
    end


  end
end
