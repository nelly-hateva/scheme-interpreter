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
  end

  it 'variable as string' do
    evaluate('(define x "42")').should eq "42"
  end

  it 'variable can not be re-defined' do
    expect { evaluate('(define y "42")', y: 3) }.to raise_error(RuntimeError)
  end
end