require 'spec_helper'

describe Expr , "define variables" do
  def parse(input)
    SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Expr.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it "define variable as number" do
    evaluate('(define x 3)').should eq 3
  end

  it "define variable as string" do
    evaluate('(define x "42")').should eq "42"
  end

  it "handle errors" do
    evaluate('(define y 3)').should eq 3
    expect { evaluate('(define y "42")', y: 3) }.to raise_error(RuntimeError)
  end
end