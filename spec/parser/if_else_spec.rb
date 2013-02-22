require 'spec_helper'

describe Interpreter::SchemeParser do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'if else' do
    @parser.parse('(if (< x 0) #t #f)').to_sexp.should eq [:if, [:<, [[:symbol, :x], [:number, 0]]], \
                                                                             [:boolean, :t], [:boolean, :f]]
    @parser.parse('(if (< x 0) (- x) x)').to_sexp.should eq [:if, [:<, [[:symbol, :x], [:number, 0]]], \
                                                                        [:-, [[:symbol, :x]]], [:symbol, :x]]
  end
end