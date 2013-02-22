require 'spec_helper'

describe Interpreter::SchemeParser , 'logic operators' do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'and' do
    @parser.parse('(and #t #f)').to_sexp.should eq [:and, [[:boolean, :t], [:boolean, :f]]]
    @parser.parse('(and (and #t #f) #f)').to_sexp.should eq [:and, \
                                               [[:and, [[:boolean, :t], [:boolean, :f]]], [:boolean, :f]]]
  end

  it 'or' do
    @parser.parse('(or #t #f)').to_sexp.should eq [:or, [[:boolean, :t], [:boolean, :f]]]
    @parser.parse('(or #f (or #t #f))').to_sexp.should eq [:or, \
                                               [[:boolean, :f], [:or, [[:boolean, :t], [:boolean, :f]]]]]
  end

  it 'not' do
    @parser.parse('(not #f)').to_sexp.should eq [:not, [[:boolean, :f]]]
    @parser.parse('(not (not #f))').to_sexp.should eq [:not, [[:not, [[:boolean, :f]]]]]
  end
end

describe Interpreter::SchemeParser , 'nested logic operators' do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it do
    @parser.parse('(and (or #t #f) (not #f))').to_sexp.should eq [:and, \
                                       [[:or, [[:boolean, :t], [:boolean, :f]]], [:not, [[:boolean, :f]]]]]
  end
end