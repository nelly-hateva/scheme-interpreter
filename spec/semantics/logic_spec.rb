require 'spec_helper'

describe 'Logic expressions' do
  def parse(input)
    Interpreter::SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Interpreter::Expression.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it 'and' do
    evaluate('(and #t #f)').should eq false
    evaluate('(and #t #t)').should eq true
    evaluate('(and (and #t #f) #f)').should eq false
    evaluate('(and (and #t #f) #f #t #f)').should eq false
  end

  it 'or' do
    evaluate('(or #t #f)').should eq true
    evaluate('(or #f #f)').should eq false
    evaluate('(or #f (or #t #f) #t #t #f)').should eq true
  end

  it 'not' do
    evaluate('(not #f)').should eq true
    evaluate('(not #t)').should eq false
    evaluate('(not (not #f))').should eq false
  end
end

describe 'Neseted logic operators' do

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
    evaluate('(and (or #t #f) (not #f))').should eq true
    evaluate('(and (or #f #f) (not #f))').should eq false
  end
end