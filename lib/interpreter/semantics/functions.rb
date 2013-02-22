module Interpreter
  class DefineFunction
    attr_reader :operator, :parameters, :body

    def self.build(operator, parameters, body)
      DefineFunction.new (Expression.build operator), \
                         parameters.map { |parameter| Expression.build parameter }, body
    end

    def initialize(operator, parameters, body)
      @operator, @parameters, @body = operator, parameters, body
    end

    def evaluate(environment = {})
      if environment.has_key? operator.value
        raise "#{operator.value}: this function was defined previously and cannot be re-defined"
      else
        environment[operator.value] = parameters, body
        operator.value
      end
    end
  end

  class CallFunction
    attr_reader :operator, :arguments

    def self.build(operator, arguments)
      CallFunction.new (Expression.build operator), \
                       arguments.map { |argument| Expression.build argument }
    end

    def initialize(operator, arguments)
      @operator, @arguments = operator, arguments
    end

    def evaluate(environment = {})
      if environment[operator.value]
        parameters, body = environment[operator.value]
        if parameters.size != arguments.size
          raise "Argument's number doesn't match"
        else
          keys = parameters.map(&:value)
          values = arguments.map { |argument| argument.evaluate(environment) }
          (Expression.build body).evaluate(environment.merge Hash[*keys.zip(values).flatten])
        end
      else
        raise "#{operator.value}: this function is not defined"
      end
    end
  end
end