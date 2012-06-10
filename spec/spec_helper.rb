require 'rubygems'
require 'spec'
require 'fileutils'
require File.dirname(__FILE__) + '/../lib/importex'

Spec::Runner.configure do |config|
  config.mock_with :rr
end
