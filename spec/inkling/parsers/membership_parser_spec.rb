require "spec_helper"

describe Inkling::Parsers::MembershipParser do
  let(:membership_parser) do
    Inkling::Parsers::MembershipParser.new(File.read("./spec/support/responses/memberships.xml"))
  end

  describe ".parse" do
    it "returns an array of Membership objects" do
      membership = membership_parser.parse
      expect(membership.length).to eq(21)
      expect(membership.first.class).to eq(Inkling::Membership)
    end
  end

  describe "#parse_membership_node" do
    let(:membership) do
      membership_node = membership_parser.xml_doc.xpath("//memberships").children.first
      membership_parser.parse_membership_node(membership_node)
    end

    it "parses a market node into a Market object" do
      expect(membership.class).to eq(Inkling::Membership)
      expect(membership.id).to eq(1035990414)
      expect(membership.portfolio).to eq(0)
      expect(membership.active).to eq(true)
      expect(membership.first_name).to eq("Bruce")
      expect(membership.last_name).to eq("Wayne")
      expect(membership.login).to eq("bdubs")
      expect(membership.email).to eq("bruce@wayne.com")
      expect(membership.balance).to eq(500000)
      expect(membership.answers.length).to eq(3)
      expect(membership.answers.first.private).to eq(false)
      expect(membership.answers.first.question_id).to eq(1234)
      expect(membership.answers.first.text).to eq("Alpha")
    end

  end
end
