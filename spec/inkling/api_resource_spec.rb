require "spec_helper"

describe Inkling::ApiResource do
  class ApiWidget < Inkling::ApiResource
    def self.attributes
      [:id, :name, :created_at]
    end
    attr_accessor *attributes
  end

  class ApiWidgety < Inkling::ApiResource
    def self.attributes
      [:id, :name, :created_at]
    end
    attr_accessor *attributes
  end

  class Note < Inkling::ApiResource
    def self.attributes
      [:id, :name, :created_at]
    end
    attr_accessor *attributes
  end

  class Inkling::Parsers::ApiWidgetParser < Inkling::Parsers::BaseParser; end;

  let(:widget) do
    ApiWidget.new(client)
  end

  let(:client) do
    double
  end

  describe ".list" do
    it "makes a GET to the collection endpoint" do
      expect(client).to receive(:make_request).with(:get, "api_widgets", {}).and_return(true.to_s)
      expect_any_instance_of(Inkling::Parsers::ApiWidgetParser).to receive(:parse)
      ApiWidget.list(client)
    end

    it "takes params" do
      expect(client).to receive(:make_request).with(:get, "api_widgets", { some: "param", another: "here" }).and_return(true.to_s)
      expect_any_instance_of(Inkling::Parsers::ApiWidgetParser).to receive(:parse)
      ApiWidget.list(client, {some: "param", another: "here"})
    end

    it "handles when no response is returned" do
      expect(client).to receive(:make_request).with(:get, "api_widgets", {}).and_return(false)
      expect(ApiWidget.list(client)).to eq(false)
    end
  end

  describe "#resource_name" do
    it "gives the underscored version of the resource name" do
      expect(ApiWidget.resource_name).to eq("api_widget")
    end

    it "gives the underscored version of the resource name" do
      expect(Note.resource_name).to eq("note")
    end
  end

  describe "collection_endpoint" do

    it "correctly pluralizes the resource names" do
      expect(ApiWidget.collection_endpoint).to eq("api_widgets")
    end

    it "correctly pluralizes the resource names" do
      expect(ApiWidgety.collection_endpoint).to eq("api_widgeties")
    end

  end

end
