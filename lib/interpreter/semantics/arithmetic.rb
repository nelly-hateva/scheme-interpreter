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
      elsif operation == :- and operands.length == 1
        - (Expression.build operands[0]).evaluate(environment)
      else
        operands.map { |operand| (Expression.build operand).evaluate(environment) }.inject(&operation)
      end
    end
  end

  class Negation
    attr_reader :operand

    def self.build(operand)
      Negation.new operand
    end

    def initialize(operand)
      @operand = operand
    end

    def evaluate(environment = {})
      - operand.evaluate(environment)
    end
  end
end