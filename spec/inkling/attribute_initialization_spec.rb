require "spec_helper"

describe Inkling::AttributeInitialization do
  class AttrWidget
    include Inkling::AttributeInitialization

    def self.attributes
      [:id, :name, :created_at]
    end
    attr_accessor *attributes
  end

  let(:widget) do
    AttrWidget.new
  end

  describe "#initialize_attributes" do
    it "sets attributes in the hash" do
      time = Time.now
      widget.initialize_attributes(id: "2", name: "widget name", created_at: time.iso8601)
      expect(widget.id).to eq(2)
      expect(widget.name).to eq("widget name")
      expect(widget.created_at.to_i).to eq(time.to_i)
    end
  end

end
