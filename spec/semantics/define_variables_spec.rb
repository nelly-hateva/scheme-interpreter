require 'spec_helper'

describe 'Define variables' do
  def parse(input)
    Interpreter::SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Interpreter::Expression.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it 'as number' do
    evaluate('(define x 3)').should eq 3
    evaluate('(define pi 3.14159)').should eq 3.14159
  end

  it 'as string' do
    evaluate('(define str "test")').should eq "test"
  end

  it 'as boolean' do
    evaluate('(define test #f)').should eq false
    evaluate('(define test #t)').should eq true
  end

  it 'as variable' do
    evaluate('(define test x)', x: 1).should eq 1
    evaluate('(define test x)', x: 'test').should eq 'test'
  end

  it 'as complex expressions' do
    evaluate('(define half (/ x 2))', x: 8).should eq 4
    evaluate('(define f (+ (* 2 4) 1))').should eq 9
    evaluate('(define g (+ x 1))', x: 2).should eq 3
    evaluate('(define len (* 2 pi radius))', pi: 3.14159, radius: 10).should eq 62.8318
  end

  it 'variable can not be re-defined' do
    expect { evaluate('(define y "42")', y: 3) }.to raise_error(RuntimeError)
  end
end