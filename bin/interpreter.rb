#!/usr/bin/env ruby
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'interpreter'

Interpreter::InteractiveShell.new.run