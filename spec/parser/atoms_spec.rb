require 'spec_helper'

describe SchemeParser , "numbers" do

  before do
    @parser = SchemeParser.new
  end

  it "can parse integer numbers" do
    @parser.parse("5").to_sexp.should eq [:number, 5]
    @parser.parse("0").to_sexp.should eq [:number, 0]
    @parser.parse("+0").to_sexp.should eq [:number, 0]
    @parser.parse("-0").to_sexp.should eq [:number, 0]
    @parser.parse("-50").to_sexp.should eq [:number, -50]
    @parser.parse("+50").to_sexp.should eq [:number, 50]
  end

  it "can parse float numbers" do
    @parser.parse("134.99999").to_sexp.should eq [:number, 134.99999]
    @parser.parse("999999999.999999999").to_sexp.should eq [:number, 999999999.999999999]
    @parser.parse("1.0e1").to_sexp.should eq [:number, 10]
    @parser.parse("2.0E2").to_sexp.should eq [:number, 200]
  end
end

describe SchemeParser , "strings" do

  before do
    @parser = SchemeParser.new
  end

  it "can parse strings" do
    @parser.parse('"SchemeParser"').to_sexp.should eq [:string, "SchemeParser"]
    @parser.parse('"Test string with\n newline"').to_sexp.should eq [:string, "Test string with\\n newline"]
  end
end

describe SchemeParser , "symbols" do

  before do
    @parser = SchemeParser.new
  end

  it 'can parse symbols' do
    @parser.parse("x").to_sexp.should eq [:symbol, :x]
    @parser.parse("x9_1").to_sexp.should eq [:symbol, :x9_1]
    @parser.parse("x0_").to_sexp.should eq [:symbol, :x0_]
    @parser.parse("xoxo_12").to_sexp.should eq [:symbol, :xoxo_12]
    @parser.parse("doctor_11").to_sexp.should eq [:symbol, :doctor_11]
    @parser.parse("u42").to_sexp.should eq [:symbol, :u42]
  end

  it 'can parse nested arithmetic expressions with symbols' do
    @parser.parse("(+ 1 (* 1 x))").to_sexp.should eq [:+, [[:number, 1], [:*, [[:number, 1], [:symbol, :x]]]]]
  end
end