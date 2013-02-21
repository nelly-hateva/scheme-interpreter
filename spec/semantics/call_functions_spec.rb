require 'spec_helper'

describe 'Call Functions' do
  def parse(input)
    Interpreter::SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Interpreter::Expression.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it 'with one arguments' do
    evaluate('(define (increment x) (+ x 1))').should eq :increment
    evaluate('(increment 5)', :increment => \
    [[(Interpreter::Expression.build [:symbol, :x])], [:+, [[:symbol, :x], [:number, 1]]]]).should eq 6
    expect { evaluate('(increment 5 7)', :increment => \
    [[(Interpreter::Expression.build [:symbol, :x])], [:+, [[:symbol, :x], [:number, 1]]]]) }.to \
                                                                                  raise_error(RuntimeError)
    expect { evaluate('(increment 5)') }.to raise_error(RuntimeError)
  end

  it 'with two arguments' do
    evaluate('(define (mul x y) (* x y))').should eq :mul
    evaluate('(mul 6 7)', :mul => \
    [[(Interpreter::Expression.build [:symbol, :x]), (Interpreter::Expression.build [:symbol, :y])], \
    [:*, [[:symbol, :x], [:symbol, :y]]]]).should eq 42
    expect { evaluate('(mul 6 7 8)', :mul => \
    [[(Interpreter::Expression.build [:symbol, :x]), (Interpreter::Expression.build [:symbol, :y])], \
    [:*, [[:symbol, :x], [:symbol, :y]]]])}.to raise_error(RuntimeError)
    expect { evaluate('(mul 6 7 )') }.to raise_error(RuntimeError)
  end

  it 'with more arguments' do
    evaluate('(define (f x y z) (* x (+ y z)))').should eq :f
    evaluate('(f 1 2 3)', :f => \
    [[(Interpreter::Expression.build [:symbol, :x]), (Interpreter::Expression.build [:symbol, :y]), \
                                                         (Interpreter::Expression.build [:symbol, :z])], \
    [:*, [[:symbol, :x], [:+, [[:symbol, :y], [:symbol, :z]]]]]]).should eq 5
    expect { evaluate('(f 1)', :f => \
    [[(Interpreter::Expression.build [:symbol, :x]), (Interpreter::Expression.build [:symbol, :y]), \
                                                         (Interpreter::Expression.build [:symbol, :z])], \
    [:*, [[:symbol, :x], [:+, [[:symbol, :y], [:symbol, :z]]]]]]) }.to raise_error(RuntimeError)
    expect { evaluate('(f 3 2 1)') }.to raise_error(RuntimeError)
  end
end