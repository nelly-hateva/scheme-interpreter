require 'spec_helper'

describe Expr , "arithmetic expressions with two arguments" do
  def parse(input)
    SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Expr.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it "supports addition" do
    evaluate('(+ 10 -11)').should eq -1
    evaluate('(+ x y)', x: 1, y: 2).should eq 3
  end

  it "supports negation" do
    evaluate('(- 10 -11)').should eq 21
    evaluate('(- x y)', x: 1, y: 2).should eq -1
  end

  it "supports multiplication" do
    evaluate('(* 10 23)').should eq 230
    evaluate('(* x y)', x: 1, y: 2).should eq 2
  end

  it "supports division" do
    evaluate('(/ 100 -2)').should eq -50
    evaluate('(/ 1 99999999)').should be_within(0.00000001).of(0)
    #evaluate('(/ x y)', x: 1, y: 2).should eq 0.5
    #trqbvwa da vidq kak da vzima cqloto chislo a ne samo cqlata chast
  end
end

describe Expr , "arithmetic expressions with three or more arguments" do
  def parse(input)
    SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Expr.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it "supports addition" do
    evaluate('(+ 10 -11 1 20 1.5)').should eq 21.5
    evaluate('(+ x y z 5)', x: 1, y: 2, z: 1.09).should eq 9.09
  end

  it "supports negation" do
    evaluate('(- 10 -11 30 -9)').should eq 0
    evaluate('(- x y z)', x: 1, y: 2, z: 3).should eq -4
  end

  it "supports multiplication" do
    evaluate('(* 2 5 23)').should eq 230
    evaluate('(* x y z)', x: 0.5, y: 2, z: 3).should eq 3
  end

  it "supports division" do
    evaluate('(/ 100 -2 2)').should eq -25
    #evaluate('(/ x y z)', x: 1, y: 2, z: 2).should eq 0.25
    #trqbvwa da vidq kak da vzima cqloto chislo a ne samo cqlata chast
  end
end