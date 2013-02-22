module Interpreter
  class Atom
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def self.build(atom, value)
      case atom
      when :number then Number.new value
      when :string then String.new value
      when :symbol then Symbol.new value
      when :boolean then Boolean.new value
      end
    end
  end

  class Number < Atom
    def evaluate(environment = {})
      value
    end
  end

  class String < Atom
    def evaluate(environment = {})
      value
    end
  end

  class Symbol < Atom
    def evaluate(environment = {})
      if environment.has_key? value
        environment[value]
      else
        raise "#{value}: this symbol is not defined"
      end
    end
  end

  class Boolean < Atom
    def evaluate(environment = {})
      value == :t
      end
    end
  end
end
