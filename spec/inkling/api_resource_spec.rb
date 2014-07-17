require "spec_helper"

describe Inkling::ApiResource do
  class Widget < Inkling::ApiResource
    def self.attributes
      [:id, :name, :created_at]
    end
    attr_accessor *attributes
  end

  let(:widget) do
    Widget.new
  end

  let(:client) do
    double
  end

  describe ".list" do
    it "makes a GET to the collection endpoint" do
      expect(client).to receive(:make_request).with(:get, "widgets", {})
      Widget.list(client)
    end

    it "takes params" do
      expect(client).to receive(:make_request).with(:get, "widgets", { some: "param", another: "here" })
      Widget.list(client, some: "param", another: "here")
    end
  end

  describe "#resource_name" do
    it "gives the underscored version of the resource name" do
      class SomeWidget < Inkling::ApiResource; end;
      expect(SomeWidget.resource_name).to eq("some_widget")
    end
  end

end
