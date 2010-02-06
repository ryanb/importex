require 'rubygems'
require 'parseexcel'

require File.expand_path(File.dirname(__FILE__) + '/importex/base')
require File.expand_path(File.dirname(__FILE__) + '/importex/column')
require File.expand_path(File.dirname(__FILE__) + '/importex/ruby_additions')

module Importex
  class ImportError < StandardError; end
  class InvalidCell < ImportError; end
  class MissingColumn < ImportError; end
end
