require 'spec_helper'

describe 'Atoms' do
  def parse(input)
    Interpreter::SchemeParser.new.parse(input).to_sexp
  end

  def build(string)
    Interpreter::Expression.build parse(string)
  end

  def evaluate(string, env = {})
    build(string).evaluate(env)
  end

  it 'evaluation of numbers' do
    evaluate('-2').should eq -2
    evaluate('0').should eq 0
    evaluate('-0.00005').should eq -0.00005
    evaluate('9999999999').should eq 9999999999
    evaluate('1.0e1').should eq 10
  end

  it 'evaluation of strings' do
    evaluate('"Ruby"').should eq "Ruby"
    evaluate('"Ruby Project\nTest"').should eq "Ruby Project\\nTest"
  end

  it 'evaluation of boolean' do
    evaluate('#t').should eq true
    evaluate('#T').should eq true
    evaluate('#f').should eq false
    evaluate('#F').should eq false
  end

  it 'evaluation of variables' do
    evaluate('x', x: 1).should eq 1
    evaluate('doctor', doctor: "who").should eq "who"
  end

  it "can not evaluate not defined variables" do
    expect { evaluate('y') }.to raise_error(RuntimeError)
  end
end