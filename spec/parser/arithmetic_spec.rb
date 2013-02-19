require 'spec_helper'

describe SchemeParser , "arithmetic operators with two arguments" do

  before do
    @parser = SchemeParser.new
  end

  it 'can parse multiplication' do
    @parser.parse("(* 2 3)").to_sexp.should eq [:*, [[:number, 2], [:number, 3]]]
  end

  #it 'can parse multiplication' do
    #@parser.parse("(* 999999.999 0)").to_sexp.should eq [:*, [[:number, 999999.999], [:number, 0]]]
  #end

  it 'can parse division' do
    result = @parser.parse("( / 6 3 )").to_sexp.should eq [:/, [[:number, 6], [:number, 3]]]
  end

  it 'can parse division' do
    @parser.parse("( / 6 0 )").to_sexp.should eq [:/, [[:number, 6], [:number, 0]]]
  end

  it 'can parse plus' do
    @parser.parse("(+ 1 2)").to_sexp.should eq [:+, [[:number, 1], [:number, 2]]]
  end

  it 'can parse minus' do
    @parser.parse("(- 3 1)").to_sexp.should eq [:-, [[:number, 3], [:number, 1]]]
  end
end

describe SchemeParser , "arithmetic operators with three or more arguments" do

  before do
    @parser = SchemeParser.new
  end

  it 'can parse multiplication' do
    @parser.parse("(* 2 3 4)").to_sexp.should eq [:*, [[:number, 2], [:number, 3], [:number, 4]]]
  end

  it 'can parse addition' do
    @parser.parse("(+ 2 3 4)").to_sexp.should eq [:+, [[:number, 2], [:number, 3], [:number, 4]]]
  end

  it 'can parse division' do
    @parser.parse("(/ 2 3 4)").to_sexp.should eq [:/, [[:number, 2], [:number, 3], [:number, 4]]]
  end

  it 'can parse negation' do
    @parser.parse("(- 2 3 4)").to_sexp.should eq [:-, [[:number, 2], [:number, 3], [:number, 4]]]
  end
end

describe SchemeParser , "nested arithmetic expressions" do

  before do
    @parser = SchemeParser.new
  end

  it 'can parse nested primitive expressions' do
    @parser.parse("(+ 1 (+ 1 3))").to_sexp.should eq [:+, [[:number, 1], [:+, [[:number, 1], [:number, 3]]]]]
    @parser.parse("(* 1 (/ 1 3))").to_sexp.should eq [:*, [[:number, 1], [:/, [[:number, 1], [:number, 3]]]]]
  end
end