require 'spec_helper'

describe Interpreter::SchemeParser , 'define functions' do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'with one argument' do
    @parser.parse('(define (increment x) (+ x 1))').to_sexp.should eq \
      [:define_function, [:symbol, :increment], [[:symbol, :x]], \
                         [:+, [[:symbol, :x], [:number, 1]]]]
  end

  it 'with two arguments' do
    @parser.parse('(define (add x y) (+ x y))').to_sexp.should eq \
      [:define_function, [:symbol, :add], [[:symbol, :x], [:symbol, :y]], \
                         [:+, [[:symbol, :x], [:symbol, :y]]]]
  end

  it 'with tree arguments' do
    @parser.parse('(define (cube x y z) (* x y z))').to_sexp.should eq \
      [:define_function, [:symbol, :cube], [[:symbol, :x], [:symbol, :y], [:symbol, :z]], \
                         [:*, [[:symbol, :x], [:symbol, :y], [:symbol, :z]]]]
  end

  it 'with more arguments' do
    @parser.parse('(define (f x y z t w) (* x (+ y z)))').to_sexp.should eq \
      [:define_function, \
      [:symbol, :f], [[:symbol, :x], [:symbol, :y], [:symbol, :z], [:symbol, :t], [:symbol, :w]], \
      [:*, [[:symbol, :x], [:+, [[:symbol, :y], [:symbol, :z]]]]]]
  end

  it 'parentheses don\'t match' do
    expect { @parser.parse('(define (increment x) (+ x 1)').to_sexp }.to raise_error(NoMethodError)
  end
end

describe Interpreter::SchemeParser , 'call functions' do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'with one argument' do
    @parser.parse('(increment 5)').to_sexp.should eq [:function, [:symbol, :increment], [[:number, 5]]]
  end

  it 'with two arguments' do
    @parser.parse('(add 42 0)').to_sexp.should eq [:function, [:symbol, :add], \
                                                              [[:number, 42], [:number, 0]]]
  end

  it 'with more arguments' do
    @parser.parse('(f 42 0 32 1 3)').to_sexp.should eq \
      [:function, [:symbol, :f], \
      [[:number, 42], [:number, 0], [:number, 32], [:number, 1], [:number, 3]]]
  end

  #it 'nested functions' do
    #@parser.parse('(increment (add 40 1)').to_sexp.should eq \
      #[:function, [:symbol, :increment], [:function, [:symbol, :add], [[:number, 40], [:number, 1]]]]
  #end
end