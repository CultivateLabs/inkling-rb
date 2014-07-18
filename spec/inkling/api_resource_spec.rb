require "spec_helper"

describe Inkling::ApiResource do
  class ApiWidget < Inkling::ApiResource
    def self.attributes
      [:id, :name, :created_at]
    end
    attr_accessor *attributes
  end

  let(:widget) do
    ApiWidget.new(client)
  end

  let(:client) do
    double
  end

  describe ".list" do
    it "makes a GET to the collection endpoint" do
      expect(client).to receive(:make_request).with(:get, "api_widgets", {})
      ApiWidget.list(client)
    end

    it "takes params" do
      expect(client).to receive(:make_request).with(:get, "api_widgets", { some: "param", another: "here" })
      ApiWidget.list(client, some: "param", another: "here")
    end
  end

  describe "#resource_name" do
    it "gives the underscored version of the resource name" do
      expect(ApiWidget.resource_name).to eq("api_widget")
    end
  end

end
