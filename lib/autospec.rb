require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'yaml'
require 'pry'
require 'selenium-webdriver'
require 'capybara-webkit'
require 'rest-client'

require_relative  'autospec/driver_helper'
require_relative  'autospec/general_helper_module'
require_relative  'autospec/logger'
require_relative  'autospec/page_helper_module'
require_relative  'autospec/spec_helper_module'

module Autospec
end