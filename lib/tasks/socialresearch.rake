# frozen_string_literal: true

require 'open-uri'
require 'json'
require 'selenium-webdriver'

# Install selenium-webdriver
# Install brew install chromedriver to allow selenium to open chrome
task(visit_page: :environment) do
  puts 'Starting...'
  visit_page('cocacola')
end

# user_login = "hannaschmitz069"
# user_password = "qwertz123456"

def visit_page(node)
  Application::VisitNodeService(node)
end
