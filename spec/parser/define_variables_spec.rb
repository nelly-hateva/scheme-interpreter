require 'spec_helper'

describe Interpreter::SchemeParser do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'define variables as atoms' do
    @parser.parse('(define x 9)').to_sexp.should eq [:define, [:symbol, :x], [:number, 9]]
    @parser.parse('(define pi 3.14159)').to_sexp.should eq [:define, [:symbol, :pi], [:number, 3.14159]]
    @parser.parse("(define y \"nelly\")").to_sexp.should eq [:define, [:symbol, :y], [:string, "nelly"]]
    @parser.parse('(define x y)').to_sexp.should eq [:define, [:symbol, :x], [:symbol, :y]]
  end

  it 'define variables as more complex expressions' do
    #@parser.parse("(define length (* 2 pi radius)").to_sexp.should eq [:define, [:symbol, :length], \
     #                                                            [:*, [[:symbol, :pi], [:symbol, :radius]]]]
  end
end