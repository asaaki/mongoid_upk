# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path("../../lib",__FILE__))

require "database_cleaner"
require "mongoid"
require "mongoid_upk"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("mongoid_upk_test")
end
