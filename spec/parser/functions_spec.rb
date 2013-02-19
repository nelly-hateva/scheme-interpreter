require 'spec_helper'

describe SchemeParser , "define functions" do

  before do
    @parser = SchemeParser.new
  end

  it 'with two arguments' do
    @parser.parse("(define (increment x) (+ x 1))").to_sexp.should eq \
      [:define_function, [:symbol, :increment], [[:symbol, :x]], \
                         [:+, [[:symbol, :x], [:number, 1]]]]
  end

  it 'with tree arguments' do
    @parser.parse("(define (add x y) (+ x y))").to_sexp.should eq \
      [:define_function, [:symbol, :add], [[:symbol, :x], [:symbol, :y]], \
                         [:+, [[:symbol, :x], [:symbol, :y]]]]
  end

  it 'with more arguments' do
    @parser.parse("(define (mul4 x y z t) (* x y z t))").to_sexp.should eq \
      [:define_function, [:symbol, :mul4], [[:symbol, :x], [:symbol, :y], [:symbol, :z], [:symbol, :t]], \
                         [:*, [[:symbol, :x], [:symbol, :y], [:symbol, :z], [:symbol, :t]]]]
  end

  it 'handle parse errors' do
    expect { @parser.parse("(define (increment x) (+ x 1)").to_sexp }.to raise_error(NoMethodError)
  end
end

describe SchemeParser , "call functions" do

  before do
    @parser = SchemeParser.new
  end

  it 'with two arguments' do
    @parser.parse("(increment 5)").to_sexp.should eq \
      [:function, [:symbol, :increment], [[:number, 5]]]
  end

  it 'with tree arguments' do
    @parser.parse("(add 42 0)").to_sexp.should eq \
      [:function, [:symbol, :add], [[:number, 42], [:number, 0]]]
  end

  it 'with more arguments' do
    @parser.parse("(mul4 42 0 42 0)").to_sexp.should eq \
      [:function, [:symbol, :mul4], [[:number, 42], [:number, 0], [:number, 42], [:number, 0]]]
  end
end