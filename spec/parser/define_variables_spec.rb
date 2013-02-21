require 'spec_helper'

describe Interpreter::SchemeParser do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'define variables' do
    @parser.parse("(define x 9)").to_sexp.should eq [:define, [:symbol, :x], [:number, 9]]
    @parser.parse("(define y \"nelly\")").to_sexp.should eq [:define, [:symbol, :y], [:string, "nelly"]]
    @parser.parse("(define x y)").to_sexp.should eq [:define, [:symbol, :x], [:symbol, :y]]
  end
end