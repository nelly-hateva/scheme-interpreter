module Interpreter
  class Define
    attr_reader :name, :value

    def self.build(name, value)
      if ((Expression.build value).is_a? Atom or (Expression.build value).is_a? Arithmetic )
        Define.new (Expression.build name).value, (Expression.build value)
      else
        raise "define: expected value to be atom or arithmetic expression"
      end
    end

    def initialize(name, value)
      @name, @value = name, value
    end

    def evaluate(environment = {})
      if environment.has_key? name
        raise "#{name}: this name was defined previously and cannot be re-defined"
      else
        environment[name] = value.evaluate(environment)
      end
    end
  end
end