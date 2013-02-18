require 'spec_helper'

describe SchemeParser , "define symbols" do

  before do
    @parser = SchemeParser.new
  end

  it 'can define symbols' do
    @parser.parse("(define x 9)").to_sexp.should eq [:define, [:symbol, :x], [:number, 9]]
    @parser.parse("(define y \"nelly\")").to_sexp.should eq [:define, [:symbol, :y], [:string, "nelly"]]
    @parser.parse("(define x y)").to_sexp.should eq [:define, [:symbol, :x], [:symbol, :y]]
  end
end