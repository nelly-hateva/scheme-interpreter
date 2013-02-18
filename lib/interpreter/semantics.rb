module Expr
  def self.build(sexpression)
    if [:number, :string, :variable].include? sexpression[0]
      Atom.build sexpression[0], sexpression[1]
    elsif [:+, :-, :*, :/].include? sexpression[0]
      Arithmetic.build sexpression[0], sexpression[1]
    elsif [:define].include? sexpression[0]
      Define.build sexpression[1], sexpression[2]
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
    when :string then My_String.new value
    when :variable then Variable.new value
    end
  end
end

class Number < Atom
  def evaluate(environment = {})
    value
  end
end

class My_String < Atom
  def evaluate(environment = {})
    value
  end
end

class Variable < Atom
  def evaluate(environment = {})
    if environment.has_key?(value)
      environment[value]
    else
      raise "#{value}: this variable is not defined"
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

  def self.build(sexpression_name, sexpression_value)
    if not ((Expr.build sexpression_name).is_a? Atom or (Expr.build sexpression_name).is_a? Arithmetic )
      raise "define: expected value to be number, string,variable or arithmetic expression"
    else
      Define.new (Expr.build sexpression_name).value, (Expr.build sexpression_value).value
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