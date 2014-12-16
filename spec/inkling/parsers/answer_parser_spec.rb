require "spec_helper"

describe Inkling::Parsers::AnswerParser do
  let(:answer_parser) do
    Inkling::Parsers::AnswerParser.new(File.read("./spec/support/responses/answers.xml"))
  end

  describe ".parse" do
    it "returns an array of Answer object" do
      answer = answer_parser.parse
      expect(answer.length).to eq(6)
      expect(answer.first.class).to eq(Inkling::Answer)
    end
  end

  describe "#parse_answer_node" do
    let(:answer) do
      answer_node = answer_parser.xml_doc.xpath("//answers").children.last
      answer_parser.parse_answer_node(answer_node)
    end

    it "parses an answer_node into an Answer object" do
      expect(answer.class).to eq(Inkling::Answer)
      expect(answer.private).to eq(false)
      expect(answer.question_id).to eq(1239)
      expect(answer.text).to eq("Never")
    end
  end
end