module Interpreter
  class IfElse
    attr_reader :test, :then_expression, :else_expression

    def self.build(test, then_expression, else_expression)
      IfElse.new (Expression.build test), (Expression.build then_expression), (Expression.build else_expression)
    end

    def initialize(test, then_expression, else_expression)
      @test, @then_expression, @else_expression = test, then_expression, else_expression
    end

    def evaluate(environment = {})
      if test.evaluate(environment)
        then_expression.evaluate(environment)
      else
        else_expression.evaluate(environment)
      end
    end
  end
end