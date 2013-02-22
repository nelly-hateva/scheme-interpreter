require 'spec_helper'

describe Interpreter::SchemeParser , 'relational operators with two arguments' do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it '==' do
    @parser.parse('(== 2 3)').to_sexp.should eq [:==, [[:number, 2], [:number, 3]]]
    @parser.parse('(== x 0.03)').to_sexp.should eq [:==, [[:symbol, :x], [:number, 0.03]]]
    @parser.parse('(== 999999.999 0)').to_sexp.should eq [:==, [[:number, 999999.999], [:number, 0]]]
  end

  it '< and <=' do
    @parser.parse('(< 6 3 )').to_sexp.should eq [:<, [[:number, 6], [:number, 3]]]
    #@parser.parse('(<= 42 y )').to_sexp.should eq [:<=, [[:number, 42], [:symbol, :y]]]
    @parser.parse('(< 1 9999 )').to_sexp.should eq [:<, [[:number, 1], [:number, 9999]]]
  end

  it '> and >=' do
    @parser.parse('(> 1 2)').to_sexp.should eq [:>, [[:number, 1], [:number, 2]]]
    @parser.parse('(> 100 0)').to_sexp.should eq [:>, [[:number, 100], [:number, 0]]]
    #@parser.parse('(>= n 0.3e2)').to_sexp.should eq [:>=, [[:symbol, :n], [:number, 30]]]
  end
end

describe Interpreter::SchemeParser , 'arithmetic operators with three or more arguments' do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it '==' do
    @parser.parse('(== 2 3 4)').to_sexp.should eq [:==, [[:number, 2], [:number, 3], [:number, 4]]]
    @parser.parse('(== 2 x 4 -2)').to_sexp.should eq [:==, [[:number, 2], [:symbol, :x], [:number, 4], \
                                                                                            [:number, -2]]]
  end

  it '< and <=' do
    @parser.parse('(< 2 3 4)').to_sexp.should eq [:<, [[:number, 2], [:number, 3], [:number, 4]]]
    #@parser.parse('(<= 1 1 1 1)').to_sexp.should eq [:<=, [[:number, 1], [:number, 1], [:number, 1], \
    #                                                                                         [:number, 1]]]
  end

  it '> and >=' do
    #@parser.parse('(>= 2 3 4)').to_sexp.should eq [:>=, [[:number, 2], [:number, 3], [:number, 4]]]
    @parser.parse('(> x y z t)').to_sexp.should eq [:>, [[:symbol, :x], [:symbol, :y], [:symbol, :z], \
                                                                                            [:symbol, :t]]]
  end
end