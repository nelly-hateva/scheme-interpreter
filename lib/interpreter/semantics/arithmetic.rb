module Interpreter
  class Arithmetic
    attr_reader :operation, :operands

    def self.build(operation, operands)
      Arithmetic.new operation, operands
    end

    def initialize(operation, operands)
      @operation, @operands = operation, operands
    end

    def evaluate(environment = {})
      if operation == :/
        operands.map { |operand| (Expression.build operand).evaluate(environment) }.inject \
                                                                                       { |a, b| a.to_f / b }
      else
        operands.map { |operand| (Expression.build operand).evaluate(environment) }.inject(&operation)
      end
    end
  end
end