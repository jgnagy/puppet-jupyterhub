require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'pp'

include RspecPuppetFacts

require 'simplecov'
require 'simplecov-console'

#SimpleCov.start do
#  add_filter '/spec'
#  add_filter '/vendor'
#  formatter SimpleCov::Formatter::MultiFormatter.new([
#    SimpleCov::Formatter::HTMLFormatter,
#    SimpleCov::Formatter::Console
#  ])
#end

RSpec.configure do |c|
  default_facts = {
    puppetversion: Puppet.version,
    facterversion: Facter.version
  }
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
  default_facts.merge!(YAML.load(File.read(File.expand_path('../default_facts.yml', __FILE__)))) if File.exist?(File.expand_path('../default_facts.yml', __FILE__))
  default_facts.merge!(YAML.load(File.read(File.expand_path('../default_module_facts.yml', __FILE__)))) if File.exist?(File.expand_path('../default_module_facts.yml', __FILE__))
  c.default_facts = default_facts
end
