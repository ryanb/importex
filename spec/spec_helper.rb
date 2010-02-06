require 'rubygems'
require 'spec'
require 'active_support'
require 'fileutils'
require File.dirname(__FILE__) + '/../lib/importex'

Spec::Runner.configure do |config|
  config.mock_with :rr
end
