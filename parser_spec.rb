#c:\Users\Nelly\Desktop\Univercity\four\seven\Ruby\Project>
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
    @parser.parse("+0").to_sexp.should eq [:number, 0]
    @parser.parse("-0").to_sexp.should eq [:number, 0]
    @parser.parse("-50").to_sexp.should eq [:number, -50]
    @parser.parse("+50").to_sexp.should eq [:number, 50]
  end
  
  it "can parse strings" do
    @parser.parse('"SchemeParser"').to_sexp.should eq [:string, "SchemeParser"]
    @parser.parse('"Test string without newline"').to_sexp.should eq [:string, "Test string without newline"]
  end

end

describe SchemeParser , "primitive operator" do

  before do
    @parser = SchemeParser.new
  end

  it 'can parse multiplication' do
    @parser.parse("(* 2 3)").to_sexp.should eq [:*, [:number, 2], [:number, 3]]
  end

  it 'can parse multiplication' do
    @parser.parse("(* 999999.999 0)").to_sexp.should eq [:*, [:number, 999999.999], [:number, 0]]
  end

  it 'can parse division' do
    result = @parser.parse("( / 6 3 )").to_sexp.should eq [:/, [:number, 6], [:number, 3]]
  end

  it 'can parse division' do
    @parser.parse("( / 6 0 )").to_sexp.should eq [:/, [:number, 6], [:number, 0]]
  end

  it 'can parse plus' do
    @parser.parse("(+ 1 2)").to_sexp.should eq [:+, [:number, 1], [:number, 2]]
  end

  it 'can parse minus' do
    @parser.parse("(- 3 1)").to_sexp.should eq [:-, [:number, 3], [:number, 1]]
  end

  #it 'can parse nested primitive expressions' do
    #@parser.parse("(+ 1 (+ 1 3))").to_sexp.should eq [:+, [:number, 1], [:+ [:number, 1], [:number, 2]]]
  #end
end