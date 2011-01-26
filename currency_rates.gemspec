# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
Gem::Specification.new do |s|
  s.name        = "currency_rates"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alastair Brunton"]
  s.email       = ["info@simplyexcited.co.uk"]
  s.homepage    = "http://github.com/pyrat/currency_rates"
  s.summary     = "Simple currency rates and conversion."
  s.description = "A little library for grabbing currency rates and providing conversion between currencies."
 
  s.required_rubygems_version = ">= 1.3.1"
  s.require_path = 'lib'
  s.files       = `git ls-files`.split("\n")
  s.add_dependency('nokogiri')
end