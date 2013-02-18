require 'spec_helper'

describe SchemeParser , "define functions" do

  before do
    @parser = SchemeParser.new
  end

  it 'can define functions' do
    @parser.parse("(define (increment x) (+ x 1))").to_sexp.should eq \
      [:define_function, [:symbol, :increment], [:symbol, :x], [:+, [[:symbol, :x], [:number, 1]]]]
    #@parser.parse("(define (add x y) (+ x y))").to_sexp.should eq \
      #[:define_function, [:symbol, :add], [:symbol, :x], [:symbol, :y], [:+, [[:symbol, :x], [:symbol, y]]]]
  end

  it 'handle parse errors' do
    expect { @parser.parse("(define (increment x) (+ x 1)").to_sexp }.to raise_error(NoMethodError)
  end
end