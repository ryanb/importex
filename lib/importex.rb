require 'spreadsheet'

require File.expand_path(File.dirname(__FILE__) + '/importex/base')
require File.expand_path(File.dirname(__FILE__) + '/importex/column')
require File.expand_path(File.dirname(__FILE__) + '/importex/core_ext/blank.rb')
require File.expand_path(File.dirname(__FILE__) + '/importex/core_ext/importex_value.rb')

module Importex
  # This is an abstract exception for errors occurred during import. It is recommended
  # that you rescue from this and handle importe errors in a clean way.
  class ImportError < StandardError; end
  
  # This exception is raised when a cell does not fit the column's :format specification.
  class InvalidCell < ImportError; end
  
  # This exception is raised when a :required column is missing.
  class MissingColumn < ImportError; end
end
