module Expr
  def self.build(sexpression)
    if [:number, :string, :symbol, :boolean].include? sexpression[0]
      Atom.build sexpression[0], sexpression[1]
    elsif [:+, :-, :*, :/].include? sexpression[0]
      Arithmetic.build sexpression[0], sexpression[1]
    elsif [:define].include? sexpression[0]
      Define.build sexpression[1], sexpression[2]
    elsif [:define_function].include? sexpression[0]
      DefineFunction.build sexpression[1], sexpression[2], sexpression[3]
    elsif [:function].include? sexpression[0]
      CallFunction.build sexpression[1], sexpression[2]
    end
  end
end

class Atom
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def self.build(atom, value)
    case atom
    when :number then Number.new value
    when :string then MyString.new value
    when :symbol then MySymbol.new value
    when :boolean then Boolean.new value
    end
  end
end

class Number < Atom
  def evaluate(environment = {})
    value
  end
end

class MyString < Atom
  def evaluate(environment = {})
    value
  end
end

class MySymbol < Atom
  def evaluate(environment = {})
    if environment.has_key?(value)
      environment[value]
    else
      raise "#{value}: this symbol is not defined"
    end
  end
end

class Boolean < Atom
  def evaluate(environment = {})
    if value == :t
      true
    else
      false
    end
  end
end

class Arithmetic
  attr_reader :operands

  def initialize(operands)
    @operands = operands
  end

  def self.build(operation, operands)
    case operation
    when :+ then Addition.new operands
    when :- then Negation.new operands
    when :* then Multiplication.new operands
    when :/ then Division.new operands
    end
  end
end

class Addition < Arithmetic
  def evaluate(environment = {})
    operands.map { |operand| (Expr.build operand).evaluate(environment) }.inject { |a, b| a + b}
  end
end

class Negation < Arithmetic
  def evaluate(environment = {})
    operands.map { |operand| (Expr.build operand).evaluate(environment) }.inject { |a, b| a - b}
  end
end

class Multiplication < Arithmetic
  def evaluate(environment = {})
    operands.map { |operand| (Expr.build operand).evaluate(environment) }.inject { |a, b| a * b}
  end
end

class Division < Arithmetic
  def evaluate(environment = {})
    operands.map { |operand| (Expr.build operand).evaluate(environment) }.inject { |a, b| a / b}
  end
end

class Define
  attr_reader :name, :value

  def self.build(name, value)
    if ((Expr.build value).is_a? Atom or (Expr.build value).is_a? Arithmetic )
      Define.new (Expr.build name).value, (Expr.build value).value
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
      environment[name] = value
    end
  end
end

class DefineFunction
  attr_reader :operator, :args, :body

  def self.build(operator, args, body)
    DefineFunction.new (Expr.build operator), (Expr.build args), (Expr.build body)
  end

  def initialize(operator, args, body)
    @operator, @args, @body = operator, args, body
  end

  def evaluate(environment = {})
    if environment.has_key? operator
      raise "#{operator}: this function was defined previously and cannot be re-defined"
    else
      environment[operator] = args, body
      operator.value
    end
  end
end

class CallFunction
  attr_reader :operator, :args

  def self.build(operator, args)
    CallFunction.new (Expr.build operator), (Expr.build args)
  end

  def initialize(operator, args)
    @operator, @args = operator, args
  end

  def evaluate(environment = {})
    if environment[operator]
      params, body = environment[operator]
      if params.size != args.size
        raise "Argument's number doesn't match"
      else 
        #(Expr.build body).evaluate(sreda v koqto params e zameneno s args)
      end
    else
      raise "#{operator.value}: this function is not defined"
    end
  end
end