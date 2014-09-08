require "spec_helper"

describe Inkling::Market do
  let(:market) do
    ApiWidget.new(client)
  end

  let(:client) do
    Inkling::Client.new(username: "rickgrimes", password: "zombies", subdomain: "walkingdead")
  end

  describe ".list" do
    it "returns an array of Market objects" do
      markets = Inkling::Market.list(client)
      expect(markets.length).to eq(30)
      expect(markets.first.class).to eq(Inkling::Market)
    end
  end

end
