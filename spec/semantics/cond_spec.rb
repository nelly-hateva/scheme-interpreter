require 'spec_helper'

describe 'Cond' do
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
    evaluate('(cond  ((< x 0) (-x)) ((> x 0) x) ((== x 0) 0))', x: 8).should eq 8
    evaluate('(cond  ((< x 0) (-x)) ((> x 0) x) ((== x 0) 0))', x: -8).should eq 8
  end
end