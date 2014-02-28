require 'spec_helper'

describe RawTransactionsParseService do
  describe "parse" do
    it "should parse transactions from an IO object" do
      input = File.read("spec/fixtures/test.csv")
      parse_service = RawTransactionsParseService.new col_sep: "\t"
      transactions = parse_service.parse(input)
      transactions.length.should == 4
    end
  end
end
