#rspec parser_spec.rb --color --format documentation 
require 'treetop'

Treetop.load 'parser'

describe "Parser", "atoms" do

  before do
    @parser = SchemeParser.new
  end

  it "can parse numbers" do
    @parser.parse("5").to_sexp.should eq [:number, 5]
    @parser.parse("134.99999").to_sexp.should eq [:number, 134.99999]
    @parser.parse("999999999.999999999").to_sexp.should eq [:number, 999999999.999999999]
    @parser.parse("0").to_sexp.should eq [:number, 0]
  end
  
  it "can parse strings" do
    @parser.parse('"SchemeParser"').to_sexp.should eq [:string, "SchemeParser"]
    @parser.parse('"Test string without newline"').to_sexp.should eq [:string, "Test string without newline"]
  end

end