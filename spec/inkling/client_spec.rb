require "spec_helper"

describe Inkling::Client do
  let(:client) { Inkling::Client.new(username: "user@example.com", password: "password", subdomain: "test") }
  let(:endpoint){ client.api_endpoint }

  before{ allow(client).to receive(:conn).and_return(double) }

  it "raises an error if no username/password is provided" do
    expect{ Inkling::Client.new }.to raise_error(Inkling::CredentialError)
  end

  it "raises an error if no subdomain is provided" do
    expect{ Inkling::Client.new(username: "user@example.com", password: "password") }.to raise_error(Inkling::SubdomainError)
  end

  describe "#make_request" do
    it "makes GET requests" do
      expect(client.conn).to receive(:get).with("#{endpoint}path.xml", nil).and_return(double(body: "", success?: true))
      client.make_request(:get, "path")
    end

    it "makes POST requests" do
      expect(client.conn).to receive(:post).with("#{endpoint}path.xml", {title: "A new doc", content: "Some doc body"}).and_return(double(body: "", success?: true))
      client.make_request(:post, "path", {title: "A new doc", content: "Some doc body"})
    end

    it "handles GET timeouts" do
      expect(client.conn).to receive(:get).with("#{endpoint}path.xml", nil).and_raise(Faraday::Error::TimeoutError, Net::ReadTimeout)
      expect(client.make_request(:get, "path")).to eq(false)
    end

    it "handles POST timeouts" do
      expect(client.conn).to receive(:post).with("#{endpoint}path.xml", {title: "Stuff", content: "Things & Misc"}).and_raise(Faraday::Error::TimeoutError, Net::ReadTimeout)
      expect(client.make_request(:post, "path", {title: "Stuff", content: "Things & Misc"})).to eq(false)
    end
  end
end

describe Inkling::Client, "#conn" do
  let(:endpoint){ client.api_endpoint }

  it "uses basic auth" do
    #client = Inkling::Client.new(username: "lukeskywalker@rebellion.com", password: "theforce", subdomain: "starwars")
    client = Inkling::Client.new(username: "admin", password: "Ch1cag0", subdomain: "home")
    expect(client.conn.headers["Authorization"]).to match(/Basic/)
  end
end
