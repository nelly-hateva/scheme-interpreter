require 'spec_helper'

describe 'Relational expressions with two arguments' do
  def parse(input)
    Interpreter::SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Interpreter::Expression.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it 'supports ==' do
    evaluate('(== 10 -11)').should eq false
    evaluate('(== x y)', x: 1, y: 1).should eq true
  end

  it 'supports < and <=' do
    #evaluate('(<= 10 -11)').should eq false
    evaluate('(< x y)', x: 1, y: 2).should eq true
  end

  it 'supports > and >=' do
    evaluate('(> 10 23)').should eq false
    #evaluate('(>= x y)', x: 1, y: 1).should eq true
  end

  it 'supports !=' do
    evaluate('(!= 10 -11)').should eq true
    evaluate('(!= x y)', x: 1, y: 1).should eq false
  end
end

describe 'Relational expressions with three or more arguments' do
  def parse(input)
    Interpreter::SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Interpreter::Expression.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it '==' do
    evaluate('(== 1 1 1 1)').should eq true
    evaluate('(== 1 y 1)', y: 1).should eq true
    evaluate('(== 1 1 2)').should eq false
  end

  it '> and >=' do
    evaluate('(> 11 -11)').should eq true
    #evaluate('(>= 11 11)').should eq true
    #evaluate('(>= 11 20)').should eq false
  end

  it '< and <=' do
    evaluate('(< 2 x y z)', x: 3, y: 5, z: 7).should eq true
    #evaluate('(<= x y z)', x: 0.5, y: 2, z: 3).should eq true
    evaluate('(< 9 x y z)', x: 3, y: 5, z: 7).should eq false
  end

  it '!=' do
    evaluate('(!= 1 1 1 1)').should eq false
    evaluate('(!= 1 y 1)', y: 1).should eq false
    evaluate('(!= 1 1 2)').should eq false
    evaluate('(!= 1 3 2)').should eq true
  end
end