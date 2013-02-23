module Interpreter
  class Cond
    attr_reader :tests

    def self.build(tests)
      Cond.new tests
    end

    def initialize(tests)
      @tests = tests
    end

    def evaluate(environment = {})
      tests.each do |test|
        if (Expression.build test[0]).evaluate(environment)
          return (Expression.build test[1]).evaluate(environment)
        end
      end
      false
    end
  end
end