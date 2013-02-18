require 'spec_helper'

describe SchemeParser , "define variables" do

  before do
    @parser = SchemeParser.new
  end

  it 'can define variables' do
    @parser.parse("(define x 9)").to_sexp.should eq [:define, [:variable, :x], [:number, 9]]
    @parser.parse("(define y \"nelly\")").to_sexp.should eq [:define, [:variable, :y], [:string, "nelly"]]
    @parser.parse("(define x y)").to_sexp.should eq [:define, [:variable, :x], [:variable, :y]]
  end
end