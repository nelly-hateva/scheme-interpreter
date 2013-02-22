module Interpreter
  class Relational
    attr_reader :comparison, :operands

    def Relational.build(comparison, operands)
      Relational.new comparison, operands
    end

    def initialize(comparison, operands)
      @comparison, @operands = comparison, operands
    end

    def evaluate(environment = {})
      values = operands.map { |operand| (Expression.build operand).evaluate(environment) }
      (1..values.length-1).each do |index|
        unless values[index-1].send comparison, values[index]
          return false
        end
      end
      true
    end
  end
end