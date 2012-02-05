# encoding: utf-8
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "rubygems"
require "bundler"
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require "rake"
require "jeweler"
require "rspec/core"
require "rspec/core/rake_task"
require "mongoid_upk/version"

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "mongoid_upk"
  gem.version = Mongoid::UPK::VERSION
  gem.homepage = "http://github.com/asaaki/mongoid_upk"
  gem.license = "MIT"
  gem.summary = %Q{Mongoid::UPK generates more unique `_id`}
  gem.description = %Q{Mongoid::UPK generates more unique `_id` by using UUID.}
  gem.email = "chris@dinarrr.com"
  gem.authors = ["Christoph Grabo"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
