module Interpreter
  module Expression
    def self.build(sexpression)
      if [:number, :string, :symbol, :boolean].include? sexpression[0]
        Atom.build sexpression[0], sexpression[1]
      elsif [:==, :<, :<=, :>, :>=].include? sexpression[0]
        Relational.build sexpression[0], sexpression[1]
      elsif [:+, :-, :*, :/].include? sexpression[0]
        Arithmetic.build sexpression[0], sexpression[1]
      elsif [:if].include? sexpression[0]
        IfElse.build sexpression[1], sexpression[2], sexpression[3]
      elsif [:define].include? sexpression[0]
        Define.build sexpression[1], sexpression[2]
      elsif [:define_function].include? sexpression[0]
        DefineFunction.build sexpression[1], sexpression[2], sexpression[3]
      elsif [:function].include? sexpression[0]
        CallFunction.build sexpression[1], sexpression[2]
      end
    end
  end
end