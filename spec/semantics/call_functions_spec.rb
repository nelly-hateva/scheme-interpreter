require 'spec_helper'

describe CallFunction do
  def parse(input)
    SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Expr.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  #it 'with two arguments' do
    #evaluate("(define (increment x) (+ x 1))
              #(increment 5)").should eq 6
  #end

  #it 'with tree arguments' do
    #evaluate("(define (add x y) (+ x y))
               #(add 5 7)").to_sexp 12
  #end

  #it 'with more arguments' do
    #evaluate("(define (mul4 x y z t) (* x y z t))
              #(mul4 1 2 3 4)").should eq 24
  #end
end