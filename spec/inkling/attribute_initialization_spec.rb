require "spec_helper"

describe Inkling::AttributeInitialization do
  class Widget
    include Inkling::AttributeInitialization

    def self.attributes
      [:id, :name, :created_at]
    end
    attr_accessor *attributes
  end

  let(:widget) do
    Widget.new
  end

  describe "#initialize_attributes" do
    it "sets attributes in the hash" do
      time = Time.now
      widget.initialize_attributes(id: "2", name: "widget name", created_at: time.iso8601)
      widget.id.should == 2
      widget.name.should == "widget name"
      widget.created_at.to_i.should == time.to_i
    end
  end

end
