require 'spec_helper'

describe Define do
  def parse(input)
    SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Expr.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it "variable as number" do
    evaluate('(define x 3)').should eq 3
  end

  it "variable as string" do
    evaluate('(define x "42")').should eq "42"
  end

  it "variable can not be re-defined" do
    evaluate('(define y 3)').should eq 3
    expect { evaluate('(define y "42")', y: 3) }.to raise_error(RuntimeError)
  end
end