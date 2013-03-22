lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include? lib

require 'vistasoft/version'
require 'rspec/autorun'

Gem::Specification.new do |s|
  s.name        = 'vistasoft'
  s.version     = Vistasoft::VERSION
  s.date        = '2013-03-21'
  s.summary     = "Integration with Vista SOAP web service"
  s.description = "Integration with Vista SOAP web service"
  s.authors     = ["Marcelo Jacobus"]
  s.email       = 'marcelo.jacobus@gmail.com'
  s.files       = ["lib/vistasoft.rb"]
  # s.homepage


  s.add_dependency "savon", '~> 2'
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency 'rb-inotify'
  s.add_development_dependency 'simplecov'
end