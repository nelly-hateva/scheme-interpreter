module Interpreter
  class ParseError < StandardError; end

  class InteractiveShell
    def initialize
      @environment = {}
    end

    def execute(line)
      case line
        when 'help' then help
        when 'exit' then raise StopIteration
        else evaluate_and_show_value parse(line)
      end
    rescue StopIteration
      raise
    rescue => e
      puts "#{e.message}"
      #puts "ERROR: #{e.class} => #{e.message}"
      #puts e.backtrace.join("\n")
    end

    def run
      loop do
        print '>> '
        execute gets.chomp
      end
    end

    def parse(string)
      result = SchemeParser.new.parse(string)
      raise ParseError if result.nil?
      Expression.build result.to_sexp
    end

    def help
      puts <<END

Ruby Course, Project - Scheme Interpreter

- type an expression to evaluate it:
(+ 1 2 3)
- you can assign values to variables:
(define x 3)
- you can define functions:
(define (f a b c) (+ a (*b c)))

END
    end

    def evaluate_and_show_value(expression)
      value = expression.evaluate(@environment)
      puts "#{value}"
    end
  end
end