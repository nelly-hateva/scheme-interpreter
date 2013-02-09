require 'treetop'
require_relative 'interpreter'

Treetop.load 'parser'

class ParseError < StandardError; end

class InteractiveShell
  def initialize
    @environment = {}
  end

  def execute(line)
  end

  def run
    loop do
      print '>> '
      execute gets.chomp
    end
  end
end

InteractiveShell.new.run