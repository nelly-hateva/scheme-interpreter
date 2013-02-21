require 'spec_helper'

describe Interpreter::SchemeParser , 'numbers' do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'integers' do
    @parser.parse('0').to_sexp.should eq [:number, 0]
    @parser.parse('+0').to_sexp.should eq [:number, 0]
    @parser.parse('-0').to_sexp.should eq [:number, 0]
    @parser.parse('42').to_sexp.should eq [:number, 42]
    @parser.parse('-50').to_sexp.should eq [:number, -50]
    @parser.parse('+1024').to_sexp.should eq [:number, 1024]
    @parser.parse('9999999999').to_sexp.should eq [:number, 9999999999]
  end

  it 'float' do
    @parser.parse('134.99999').to_sexp.should eq [:number, 134.99999]
    @parser.parse('999999999.999999999').to_sexp.should eq [:number, 999999999.999999999]
    @parser.parse('1.0e1').to_sexp.should eq [:number, 10]
    @parser.parse('2.0E2').to_sexp.should eq [:number, 200]
    @parser.parse('0.1E-10').to_sexp.should eq [:number, 0.00000000001]
  end
end

describe Interpreter::SchemeParser do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'strings' do
    @parser.parse('"SchemeParser"').to_sexp.should eq [:string, "SchemeParser"]
    @parser.parse('"Test string with\n newline"').to_sexp.should eq [:string, "Test string with\\n newline"]
  end
end

describe Interpreter::SchemeParser do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'symbols' do
    @parser.parse('x').to_sexp.should eq [:symbol, :x]
    @parser.parse('x12_').to_sexp.should eq [:symbol, :x12_]
    @parser.parse('f').to_sexp.should eq [:symbol, :f]
    @parser.parse('increment').to_sexp.should eq [:symbol, :increment]
    @parser.parse('the_doctor').to_sexp.should eq [:symbol, :the_doctor]
  end
end

describe Interpreter::SchemeParser do

  before do
    @parser = Interpreter::SchemeParser.new
  end

  it 'boolean' do
    @parser.parse('#t').to_sexp.should eq [:boolean, :t]
    @parser.parse('#T').to_sexp.should eq [:boolean, :t]
    @parser.parse('#f').to_sexp.should eq [:boolean, :f]
    @parser.parse('#F').to_sexp.should eq [:boolean, :f]
  end
end