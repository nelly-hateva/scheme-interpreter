require 'spec_helper'

describe 'If_Else' do
  def parse(input)
    Interpreter::SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Interpreter::Expression.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it do
    evaluate('(if (> x 0) x (- x))', x: 8).should eq 8
    #evaluate('(if (> x 0) x (- x))', x: -8).should eq 8
    evaluate('(if (> x 0) #T #F)', x: 8).should eq true
    evaluate('(if (> x 0) #T #F)', x: -8).should eq false
  end
end