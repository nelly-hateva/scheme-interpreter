require 'spec_helper'

describe Interpreter::SchemeParser do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'cond' do
    @parser.parse('(cond  ((< x 0) (-x)) ((> x 0) x) ((== x 0) 0))').to_sexp.should eq \
      [:cond, [ [[:<, [[:symbol, :x], [:number, 0]]], [:-, [[:symbol, :x]]]], \
      [[:>, [[:symbol, :x], [:number, 0]]], [:symbol, :x]], \
      [[:==, [[:symbol, :x], [:number, 0]]], [:number, 0]] ]]
  end
end