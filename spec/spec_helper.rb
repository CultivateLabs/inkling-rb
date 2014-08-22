require 'pry'
require 'inkling-rb'

Dir["./spec/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end