module Interpreter
  class Logic
    attr_reader :operation, :operands

    def Logic.build(operation, operands)
      Logic.new operation, operands
    end

    def initialize(operation, operands)
      @operation, @operands = operation, operands
    end

    def evaluate(environment = {})
      if operation != :not
        ruby_operation = case operation
          when :and then :&
          when :or then :^
        end
        operands.map { |operand| (Expression.build operand).evaluate(environment) }.inject(&ruby_operation)
      else
        not operands.map { |operand| (Expression.build operand).evaluate(environment) }.first
      end
    end
  end
end