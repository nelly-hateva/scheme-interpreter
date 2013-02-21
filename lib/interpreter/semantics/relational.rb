module Interpreter
  class Relational
    include Comparable

    attr_reader :comparison, :operands

    def self.build(comparison, operands)
      Arithmetic.new comparison, operands
    end

    def initialize(comparison, operands)
      @comparison, @operands = comparison, operands
    end

    def evaluate(environment = {})

    end
  end
end